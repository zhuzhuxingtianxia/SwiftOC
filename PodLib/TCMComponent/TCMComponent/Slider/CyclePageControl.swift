//
//  CyclePageControl.swift
//  TCMComponent
//
//  Created by ZZJ on 2019/7/22.
//

import UIKit

// MARK: - LLFilledPageControl

open class LLFilledPageControl: UIView {
    
    // MARK: - PageControl
    
    
    open var pageCount: Int = 0 {
        didSet {
            updateNumberOfPages(pageCount)
        }
    }
    open var progress: CGFloat = 0 {
        didSet {
            updateActivePageIndicatorMasks(forProgress: progress)
        }
    }
    open var currentPage: Int {
        return Int(round(progress))
    }
    
    
    // MARK: - Appearance
    
    override open var tintColor: UIColor! {
        didSet {
            inactiveLayers.forEach() { $0.backgroundColor = tintColor.cgColor }
        }
    }
    open var inactiveRingWidth: CGFloat = 1 {
        didSet {
            updateActivePageIndicatorMasks(forProgress: progress)
        }
    }
    open var indicatorPadding: CGFloat = 8 {
        didSet {
            layoutPageIndicators(inactiveLayers)
        }
    }
    open var indicatorRadius: CGFloat = 4 {
        didSet {
            layoutPageIndicators(inactiveLayers)
        }
    }
    
    fileprivate var indicatorDiameter: CGFloat {
        return indicatorRadius * 2
    }
    
    fileprivate var inactiveLayers = [CALayer]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        pageCount = 0
        progress = 0
        inactiveRingWidth = 1
        indicatorPadding = 8
        indicatorRadius = 4
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - State Update
    
    fileprivate func updateNumberOfPages(_ count: Int) {
        // no need to update
        guard count != inactiveLayers.count else { return }
        // reset current layout
        inactiveLayers.forEach() { $0.removeFromSuperlayer() }
        inactiveLayers = [CALayer]()
        // add layers for new page count
        inactiveLayers = stride(from: 0, to:count, by:1).map() { _ in
            let layer = CALayer()
            layer.backgroundColor = self.tintColor.cgColor
            self.layer.addSublayer(layer)
            return layer
        }
        layoutPageIndicators(inactiveLayers)
        updateActivePageIndicatorMasks(forProgress: progress)
        self.invalidateIntrinsicContentSize()
    }
    
    
    // MARK: - Layout
    
    fileprivate func updateActivePageIndicatorMasks(forProgress progress: CGFloat) {
        // ignore if progress is outside of page indicators' bounds
        guard progress >= 0 && progress <= CGFloat(pageCount - 1) else { return }
        
        // mask rect w/ default stroke width
        let insetRect = CGRect(x: 0, y: 0, width: indicatorDiameter, height: indicatorDiameter).insetBy(dx: inactiveRingWidth, dy: inactiveRingWidth)
        let leftPageFloat = trunc(progress)
        let leftPageInt = Int(progress)
        
        // inset right moving page indicator
        let spaceToMove = insetRect.width / 2
        let percentPastLeftIndicator = progress - leftPageFloat
        let additionalSpaceToInsetRight = spaceToMove * percentPastLeftIndicator
        let closestRightInsetRect = insetRect.insetBy(dx: additionalSpaceToInsetRight, dy: additionalSpaceToInsetRight)
        
        // inset left moving page indicator
        let additionalSpaceToInsetLeft = (1 - percentPastLeftIndicator) * spaceToMove
        let closestLeftInsetRect = insetRect.insetBy(dx: additionalSpaceToInsetLeft, dy: additionalSpaceToInsetLeft)
        
        // adjust masks
        for (idx, layer) in inactiveLayers.enumerated() {
            let maskLayer = CAShapeLayer()
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            
            let boundsPath = UIBezierPath(rect: layer.bounds)
            let circlePath: UIBezierPath
            if leftPageInt == idx {
                circlePath = UIBezierPath(ovalIn: closestLeftInsetRect)
            } else if leftPageInt + 1 == idx {
                circlePath = UIBezierPath(ovalIn: closestRightInsetRect)
            } else {
                circlePath = UIBezierPath(ovalIn: insetRect)
            }
            boundsPath.append(circlePath)
            maskLayer.path = boundsPath.cgPath
            layer.mask = maskLayer
        }
    }
    
    fileprivate func layoutPageIndicators(_ layers: [CALayer]) {
        let layerDiameter = indicatorRadius * 2
        var layerFrame = CGRect(x: 0, y: 0, width: layerDiameter, height: layerDiameter)
        layers.forEach() { layer in
            layer.cornerRadius = self.indicatorRadius
            layer.frame = layerFrame
            layerFrame.origin.x += layerDiameter + indicatorPadding
        }
        // 布局
        let oldFrame = self.frame
        let width = CGFloat(inactiveLayers.count) * layerDiameter + CGFloat(inactiveLayers.count - 1) * indicatorPadding
        self.frame = CGRect.init(x: UIScreen.main.bounds.width / 2 - width / 2, y: oldFrame.origin.y, width: width, height: oldFrame.size.height)
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let layerDiameter = indicatorRadius * 2
        return CGSize(width: CGFloat(inactiveLayers.count) * layerDiameter + CGFloat(inactiveLayers.count - 1) * indicatorPadding,
                      height: layerDiameter)
    }
}


// MARK: - LLImagePageControl

open class LLImagePageControl: UIPageControl {
    
    
    open var dotInActiveImage: UIImage = UIImage(named: "lldotInActive.png", in: Bundle(for: LLImagePageControl.self), compatibleWith: nil)!
    open var dotActiveImage: UIImage = UIImage(named: "lldotActive.png", in: Bundle(for: LLImagePageControl.self), compatibleWith: nil)!
    
    override open var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override open var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    func updateDots() {
        var i = 0
        for view in self.subviews {
            var imageView = self.imageView(forSubview: view)
            if imageView == nil {
                if i == 0 {
                    imageView = UIImageView(image: dotInActiveImage)
                } else {
                    imageView = UIImageView(image: dotActiveImage)
                }
                imageView!.center = view.center
                imageView?.frame = CGRect.init(x: view.frame.origin.x, y: view.frame.origin.y+2, width: 8, height: 8)
                view.addSubview(imageView!)
                view.clipsToBounds = false
            }
            
            if i == self.currentPage {
                imageView!.image = dotInActiveImage
            } else {
                imageView!.image = dotActiveImage
            }
            i += 1
        }
    }
    
    fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }
}

// MARK: - LLPillPageControl

open class LLPillPageControl: UIView {
    
    // MARK: - PageControl
    
    open var pageCount: Int = 0 {
        didSet {
            updateNumberOfPages(pageCount)
        }
    }
    open var progress: CGFloat = 0 {
        didSet {
            layoutActivePageIndicator(progress)
        }
    }
    open var currentPage: Int {
        return Int(round(progress))
    }
    
    
    // MARK: - Appearance
    
    open var pillSize: CGSize = CGSize(width: 20, height: 2.5) {
        didSet {
            
        }
    }
    open var activeTint: UIColor = UIColor.white {
        didSet {
            activeLayer.backgroundColor = activeTint.cgColor
        }
    }
    open var inactiveTint: UIColor = UIColor(white: 1, alpha: 0.3) {
        didSet {
            inactiveLayers.forEach() { $0.backgroundColor = inactiveTint.cgColor }
        }
    }
    open var indicatorPadding: CGFloat = 7 {
        didSet {
            layoutInactivePageIndicators(inactiveLayers)
        }
    }
    
    fileprivate var inactiveLayers = [CALayer]()
    
    fileprivate lazy var activeLayer: CALayer = { [unowned self] in
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint.zero,
                             size: CGSize(width: self.pillSize.width, height: self.pillSize.height))
        layer.backgroundColor = self.activeTint.cgColor
        layer.cornerRadius = self.pillSize.height/2
        layer.actions = [
            "bounds": NSNull(),
            "frame": NSNull(),
            "position": NSNull()]
        return layer
        }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        pageCount = 0
        progress = 0
        indicatorPadding = 7
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - State Update
    
    fileprivate func updateNumberOfPages(_ count: Int) {
        // no need to update
        guard count != inactiveLayers.count else { return }
        // reset current layout
        inactiveLayers.forEach() { $0.removeFromSuperlayer() }
        inactiveLayers = [CALayer]()
        // add layers for new page count
        inactiveLayers = stride(from: 0, to:count, by:1).map() { _ in
            let layer = CALayer()
            layer.backgroundColor = self.inactiveTint.cgColor
            self.layer.addSublayer(layer)
            return layer
        }
        layoutInactivePageIndicators(inactiveLayers)
        // ensure active page indicator is on top
        self.layer.addSublayer(activeLayer)
        layoutActivePageIndicator(progress)
        self.invalidateIntrinsicContentSize()
    }
    
    
    // MARK: - Layout
    
    fileprivate func layoutActivePageIndicator(_ progress: CGFloat) {
        // ignore if progress is outside of page indicators' bounds
        guard progress >= 0 && progress <= CGFloat(pageCount - 1) else { return }
        let denormalizedProgress = progress * (pillSize.width + indicatorPadding)
        activeLayer.frame.origin.x = denormalizedProgress
    }
    
    fileprivate func layoutInactivePageIndicators(_ layers: [CALayer]) {
        var layerFrame = CGRect(origin: CGPoint.zero, size: pillSize)
        layers.forEach() { layer in
            layer.cornerRadius = layerFrame.size.height / 2
            layer.frame = layerFrame
            layerFrame.origin.x += layerFrame.width + indicatorPadding
        }
        // 布局
        let oldFrame = self.frame
        let width = CGFloat(inactiveLayers.count) * pillSize.width + CGFloat(inactiveLayers.count - 1) * indicatorPadding
        self.frame = CGRect.init(x: UIScreen.main.bounds.width / 2 - width / 2, y: oldFrame.origin.y, width: width, height: oldFrame.size.height)
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: CGFloat(inactiveLayers.count) * pillSize.width + CGFloat(inactiveLayers.count - 1) * indicatorPadding,
                      height: pillSize.height)
    }
}


// MARK: - LLSnakePageControl

open class LLSnakePageControl: UIView {
    
    // MARK: - PageControl
    
    open var pageCount: Int = 0 {
        didSet {
            updateNumberOfPages(pageCount)
        }
    }
    open var progress: CGFloat = 0 {
        didSet {
            layoutActivePageIndicator(progress)
        }
    }
    open var currentPage: Int {
        return Int(round(progress))
    }
    
    
    // MARK: - Appearance
    
    open var activeTint: UIColor = UIColor.white {
        didSet {
            activeLayer.backgroundColor = activeTint.cgColor
        }
    }
    open var inactiveTint: UIColor = UIColor(white: 1, alpha: 0.3) {
        didSet {
            inactiveLayers.forEach() { $0.backgroundColor = inactiveTint.cgColor }
        }
    }
    open var indicatorPadding: CGFloat = 10 {
        didSet {
            layoutInactivePageIndicators(inactiveLayers)
        }
    }
    open var indicatorRadius: CGFloat = 5 {
        didSet {
            layoutInactivePageIndicators(inactiveLayers)
        }
    }
    
    fileprivate var indicatorDiameter: CGFloat {
        return indicatorRadius * 2
    }
    fileprivate var inactiveLayers = [CALayer]()
    fileprivate lazy var activeLayer: CALayer = { [unowned self] in
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint.zero,
                             size: CGSize(width: self.indicatorDiameter, height: self.indicatorDiameter))
        layer.backgroundColor = self.activeTint.cgColor
        layer.cornerRadius = self.indicatorRadius
        layer.actions = [
            "bounds": NSNull(),
            "frame": NSNull(),
            "position": NSNull()]
        return layer
        }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        pageCount = 0
        progress = 0
        indicatorPadding = 8
        indicatorRadius = 4
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - State Update
    
    fileprivate func updateNumberOfPages(_ count: Int) {
        // no need to update
        guard count != inactiveLayers.count else { return }
        // reset current layout
        inactiveLayers.forEach() { $0.removeFromSuperlayer() }
        inactiveLayers = [CALayer]()
        // add layers for new page count
        inactiveLayers = stride(from: 0, to:count, by:1).map() { _ in
            let layer = CALayer()
            layer.backgroundColor = self.inactiveTint.cgColor
            self.layer.addSublayer(layer)
            return layer
        }
        layoutInactivePageIndicators(inactiveLayers)
        // ensure active page indicator is on top
        self.layer.addSublayer(activeLayer)
        layoutActivePageIndicator(progress)
        self.invalidateIntrinsicContentSize()
    }
    
    
    // MARK: - Layout
    
    fileprivate func layoutActivePageIndicator(_ progress: CGFloat) {
        // ignore if progress is outside of page indicators' bounds
        guard progress >= 0 && progress <= CGFloat(pageCount - 1) else { return }
        let denormalizedProgress = progress * (indicatorDiameter + indicatorPadding)
        let distanceFromPage = abs(round(progress) - progress)
        var newFrame = activeLayer.frame
        let widthMultiplier = (1 + distanceFromPage*2)
        newFrame.origin.x = denormalizedProgress
        newFrame.size.width = newFrame.height * widthMultiplier
        activeLayer.frame = newFrame
    }
    
    fileprivate func layoutInactivePageIndicators(_ layers: [CALayer]) {
        let layerDiameter = indicatorRadius * 2
        var layerFrame = CGRect(x: 0, y: 0, width: layerDiameter, height: layerDiameter)
        layers.forEach() { layer in
            layer.cornerRadius = self.indicatorRadius
            layer.frame = layerFrame
            layerFrame.origin.x += layerDiameter + indicatorPadding
        }
        // 布局
        let oldFrame = self.frame
        let width = CGFloat(inactiveLayers.count) * indicatorDiameter + CGFloat(inactiveLayers.count - 1) * indicatorPadding
        self.frame = CGRect.init(x: UIScreen.main.bounds.width / 2 - width / 2, y: oldFrame.origin.y, width: width, height: oldFrame.size.height)
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: CGFloat(inactiveLayers.count) * indicatorDiameter + CGFloat(inactiveLayers.count - 1) * indicatorPadding,
                      height: indicatorDiameter)
    }
}
