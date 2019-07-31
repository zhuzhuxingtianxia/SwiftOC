//
//  ZJTabPageView.swift
//  TCMComponent
//
//  Created by ZZJ on 2019/7/27.
//

import UIKit

@objc public protocol ZJTabPageViewDelegate {
    @objc optional func tabPageView(_ pageView:ZJTabPageView, didSelectIndex index: NSInteger)
}

open class ZJTabPageView: UIView {
    
    /// 数据源
    open var dataSource: Array<String> = [] {
        didSet {
            collectionView.reloadData()

            if currentIndex > 0 {
                if currentIndex > dataSource.count {
                    currentIndex = dataSource.count - 1
                }
                collectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: false)
                // + .milliseconds(300)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) {
                    let titleWidth = self.getContentWidth(title: self.dataSource[self.currentIndex])
                    let itemW = self.itemWidth ?? titleWidth
                    self.indicator.bounds = CGRect.init(x: 0, y: 0, width: itemW, height: self.indicator.bounds.height)
                    self.moveIndicator(animated: false)
                }
               
            }else {
                if itemWidth == nil {
                    let titleWidth = getContentWidth(title: dataSource[currentIndex])
                    indicator.bounds = CGRect.init(x: 0, y: 0, width: titleWidth, height: indicator.bounds.height)
                }
                moveIndicator(animated: false)
            }
        }
    }
    
    /// 协议
    open weak var delegate: ZJTabPageViewDelegate?
    
    // 指定选中的索引
    open var selectIndex:NSInteger {
        set {
            let indexPath = IndexPath.init(item: newValue, section: 0)
            
            didSelectItemAtIndexPath(indexPath: indexPath)
            guard itemWidth == nil else {
                return
            }
            moveIndicator(animated: true)
        }
        
        get {
            return currentIndex
        }
    }
    
    /// 指示器移动比例,该属性必须设置itemWidth，否则无效
    open var moveRatio: CGFloat? {
        didSet {
            guard hideIndicator == false,itemWidth != nil else {
                return
            }
            
            let ratio = moveRatio! > 1 ? 1 : moveRatio!
            let centerX:CGFloat = (collectionView.contentSize.width - indicator.bounds.width - itemSpacing) * ratio + (indicator.bounds.width+itemSpacing)/2.0
            indicator.center = CGPoint.init(x: centerX, y: collectionView.bounds.height - indicatorHeight/2.0)
        }
    }
    
    
    // 未选中字体颜色
    open var titleNormalColor:UIColor = UIColor.black
    
    // 选中字体颜色
    open var titleSelectColor:UIColor = UIColor.red {
        didSet {
            indicator.backgroundColor = titleSelectColor
        }
    }
    /// 未选中字体大小
    open var titleNomalFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// 选中的字体大小
    open var titleSelectFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    //指示器高度
    open var indicatorHeight: CGFloat = 2 {
        didSet {
            indicator.bounds.size = CGSize.init(width: indicator.bounds.width, height: indicatorHeight)
        }
    }
    //是否隐藏指示器
    open var hideIndicator: Bool = false {
        didSet {
            indicator.isHidden = hideIndicator
        }
    }
    
    //item固定宽度
    open var itemWidth: CGFloat? {
        didSet {
            collectionView.reloadData()
            indicator.bounds.size = CGSize.init(width: itemWidth!, height: indicator.bounds.height)
        }
    }
    /// item间隔
    open var itemSpacing: CGFloat = 10
    
    ///选中的item的索引值
    fileprivate var currentIndex: NSInteger = 0
    
    //item默认宽,设置get方法只读模式
    fileprivate var nomalItemWidth:CGFloat {
        return 40.0
    }
    
    fileprivate var fontScale:CGFloat {
        let fontScale = titleSelectFont.pointSize/titleNomalFont.pointSize
        return fontScale
    }
    
    /// 容器 UICollectionView
    fileprivate lazy var collectionView: UICollectionView = {
       
      let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
       let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
       
        collectionView.register(ZJTabPageViewCell.self, forCellWithReuseIdentifier: "ZJTabPageViewCell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = UIColor.yellow
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        
        return collectionView
    }()
    
    /// UICollectionViewItem活动指示器
    fileprivate lazy var indicator: UIView = {
        let indicator = UIView.init()
        indicator.backgroundColor = UIColor.red
        indicator.bounds.size = CGSize.init(width: nomalItemWidth, height: 2)
        return indicator
    }()
    
    //MARK: -  Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.addSubview(indicator)
        
    }
    
    open override var frame: CGRect {
        didSet {
            collectionView.frame = self.bounds
            moveIndicator(animated: false)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - layoutSubviews
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func moveIndicator(animated: Bool) {
        
        let cell = collectionView.cellForItem(at: IndexPath.init(item: currentIndex, section: 0))
    
        var postionX:CGFloat = 0
        if cell == nil {
            let titleWidth = dataSource.count>0 ? getContentWidth(title: dataSource[currentIndex]):nomalItemWidth
            let itemW = itemWidth ?? titleWidth
            postionX = (itemW + itemSpacing) / 2.0 + CGFloat(currentIndex) * itemW
        }else {
            postionX = (cell?.center.x)!
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.indicator.center = CGPoint.init(x: postionX, y: self.collectionView.bounds.height - self.indicatorHeight/2.0)
            }
        }else {
            indicator.center = CGPoint.init(x: postionX, y: collectionView.bounds.height - indicatorHeight/2.0)
        }
        
    }
}

//MARK: - UICollectionViewDataSource
extension ZJTabPageView:UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJTabPageViewCell", for: indexPath) as! ZJTabPageViewCell
        cell.label.text = dataSource[indexPath.item]
        
        if currentIndex == indexPath.item {
            cell.label.textColor = titleSelectColor
            
            cell.label.transform = CGAffineTransform.init(scaleX: fontScale, y: fontScale)
            cell.label.font = titleSelectFont
        }else{
            cell.label.textColor = titleNormalColor
            cell.label.transform = .identity
            cell.label.font = titleNomalFont
        }
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ZJTabPageView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var titleWidth = getContentWidth(title: dataSource[indexPath.item])
        
        titleWidth *= fontScale
        let itemW = itemWidth ?? titleWidth
        
        return CGSize.init(width: itemW, height: collectionView.bounds.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: itemSpacing/2.0, bottom: 0, right: itemSpacing/2.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    fileprivate func getContentWidth(title: String) -> CGFloat {
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 50)
       //NSAttributedString.Key.font或 kCTFontAttributeName
        let attribute = [NSAttributedString.Key.font: titleSelectFont]
        let options = NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesFontLeading)
        let rect = title.boundingRect(with: size, options: options, attributes: attribute, context: nil)
        
        return rect.width+1
    }
}

//MARK: - UICollectionViewDelegate
extension ZJTabPageView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        didSelectItemAtIndexPath(indexPath: indexPath)
        guard itemWidth == nil else {
            return
        }
        moveIndicator(animated: true)
    }
    //选中方法
    fileprivate func didSelectItemAtIndexPath(indexPath: IndexPath){
        guard indexPath.item != currentIndex else {
            return
        }
        
        let selectedCell = collectionView.cellForItem(at: IndexPath.init(item: currentIndex, section: 0)) as? ZJTabPageViewCell
        let targetCell = collectionView.cellForItem(at: IndexPath.init(item: indexPath.item, section: 0)) as? ZJTabPageViewCell
        
        if selectedCell != nil {
            selectedCell!.label.textColor = titleNormalColor
        }
        if targetCell != nil {
            targetCell!.label.textColor = titleSelectColor
        }
        
        UIView.animate(withDuration: 0.15, animations: {
            if selectedCell != nil {
                selectedCell?.label.transform = .identity
//                selectedCell?.label.layer.transform = CATransform3DIdentity
            }
            if targetCell != nil {
                targetCell?.label.transform = CGAffineTransform.init(scaleX: self.fontScale, y: self.fontScale)
//                targetCell?.label.layer.transform = CATransform3DMakeScale(self.fontScale, self.fontScale, 1.0)
            }
            
        }) { (finished) in
            if selectedCell != nil {
                selectedCell?.label.font = self.titleNomalFont
            }
            if targetCell != nil {
                targetCell?.label.font = self.titleSelectFont
            }
        }
        
        currentIndex = indexPath.item
        if currentIndex < dataSource.count {
            collectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            
            if itemWidth == nil {
                let titleWidth = getContentWidth(title: dataSource[indexPath.item])
                indicator.bounds = CGRect.init(x: 0, y: 0, width: titleWidth, height: indicator.bounds.height)
            }else {
                indicator.bounds = CGRect.init(x: 0, y: 0, width: itemWidth!, height: indicator.bounds.height)
            }
            
        }
        
        if let delegate = self.delegate {
            delegate.tabPageView!(self, didSelectIndex: indexPath.item)
        }
    }
    
}

//MARK: - UIScrollViewDelegate
public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
}

///////////////////////////////////////////

fileprivate class ZJTabPageViewCell: UICollectionViewCell {
    
    fileprivate lazy var label:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        return label;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
