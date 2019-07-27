//
//  FlowPageView.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/24.
// 上下翻转的视图

import UIKit

@objc public protocol FlowPageViewDelegate {
    @objc func flowPageView(_ pageView:FlowPageView, pageItem item:Any) -> UIView
    
    @objc optional func flowPageView(_ pageView:FlowPageView, didSelectIndex index: NSInteger)
}

open class FlowPageView: UIView {
    // MAKR: DataSource
    open var items: Array<Any> = []{
        didSet {
            totalItemsCount = items.count * 100
            if items.count > 1{
                setupTimer()
            }else{
                invalidateTimer()
            }
            
            collectionView.reloadData()
        }
    }
    /// 协议
    open weak var delegate: FlowPageViewDelegate?

    /// 容器组件 UICollectionView
    fileprivate var collectionView: UICollectionView!
    fileprivate var flowLayout: UICollectionViewFlowLayout?
    
    /// 计时器
    fileprivate var dtimer: DispatchSourceTimer?
    fileprivate var totalItemsCount:NSInteger! = 1
    //MARK: - init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        buildView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }
    deinit {
        invalidateTimer()
    }
    
    //MARK: - layoutSubviews
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
        flowLayout?.itemSize = self.frame.size
        
        if items.count > 0{
            collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .centeredVertically, animated: false)
        }
    }
    
}

//MARK: - UICollectionViewDelegate
extension FlowPageView:UICollectionViewDelegate,UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount == 0 ? 1:totalItemsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlowPageViewCell", for: indexPath) as! FlowPageViewCell
        if let delegate = delegate  {
            let anyModel = items[Int(indexPath.item % items.count)]
            let content:UIView = delegate.flowPageView(self, pageItem: anyModel)
            
            cell.contentView.addSubview(content)
        }
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //放置内存持续增加
       let subViews = cell.contentView.subviews
        for subview in subViews {
            subview.removeFromSuperview()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.flowPageView!(self, didSelectIndex: Int(indexPath.item % items.count))
        }
    }
    
}

// MARK: -  UIScrollViewDelegate
extension FlowPageView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

// MARK: - 定时器模块
extension FlowPageView {
    /// 添加Timer
    func setupTimer() {
        // 仅一个数据时不进行滚动操纵
        if self.items.count <= 1 { return }
        
        invalidateTimer()
        
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now()+3.0, repeating: 3.0)
        timer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.automaticScroll()
            }
        }
        // 继续
        timer.resume()
        
        dtimer = timer
    }
    
    /// 关闭倒计时
    func invalidateTimer() {
        dtimer?.cancel()
        dtimer = nil
    }
}

//MARK: - ScrollEvent
extension FlowPageView {
    func automaticScroll() {
        if items.count == 0 {return}
        let targetIndex = currentIndex() + 1
        print("\(targetIndex)")
        scollToIndex(targetIndex: targetIndex)
    }
    
    /// 滚动到指定位置
    func scollToIndex(targetIndex: Int) {
        if targetIndex >= totalItemsCount {
            collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .centeredVertically, animated: false)
            return
        }
        collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: .centeredVertically, animated: true)
    }
    
    func currentIndex() -> NSInteger{
        if collectionView.frame.width == 0 || collectionView.frame.height == 0 {
            return 0
        }
        
        var index = 0
        index = NSInteger(collectionView.contentOffset.y + (flowLayout?.itemSize.height)! * 0.5)/NSInteger((flowLayout?.itemSize.height)!)
        
        return index
    }
}

// MARK: - BuildView
extension FlowPageView {
    
    func buildView() {
        let tempFlowLayout = UICollectionViewFlowLayout.init()
        tempFlowLayout.minimumLineSpacing = 0
        tempFlowLayout.scrollDirection = .vertical
        flowLayout = tempFlowLayout
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: tempFlowLayout)
        collectionView.register(FlowPageViewCell.self, forCellWithReuseIdentifier: "FlowPageViewCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
//        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        self.addSubview(collectionView)
    }
}



///////////////////////////////////////////

fileprivate class FlowPageViewCell: UICollectionViewCell {
    
}
