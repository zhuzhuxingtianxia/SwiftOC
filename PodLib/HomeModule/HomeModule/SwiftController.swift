//
//  SwiftController.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/19.
//

import UIKit
import TCMBase
import TCMComponent

class SwiftController: UIViewController {
    var button:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("按钮", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(clickAction(sender:)), for: UIControl.Event.touchUpInside)
        btn.frame = CGRect.init(x: 20, y: 100, width: 80, height: 40)
        return btn
    }()
    var imgView:UIImageView = {
        let img = UIImageView.init()
        img.frame = CGRect.init(x: 10, y: 200, width: 40, height: 40)
        img.backgroundColor = UIColor.red
        let image = UIImage.init(named: "welfare", in: Bundle.init(for: SwiftController.self), compatibleWith: nil)
        img.image = image
        
        return img
    }()
    var label:UILabel = {
       let label = UILabel.init()
        label.frame = CGRect.init(x: 60, y: 200, width: 300, height: 40)
        return label
        
    }()
    
    lazy var tabpage:ZJTabPageView = {
        let page = ZJTabPageView.init(frame: CGRect.init(x: 0, y: 300, width: UIScreen.main.bounds.size.width, height: 40))
        page.selectIndex = 1
//        page.itemWidth = 80
        page.titleSelectFont = UIFont.systemFont(ofSize: 16)
        page.delegate = self
       return page;
    }()
    
    var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(imgView)
        view.addSubview(tabpage)
        tabpage.dataSource = ["标题0","标题1标题1","标题234","标题3","标题400","标题5","标题6","标题7"]
        buildView()
    }
    
    func buildView() {
        let scrollView = UIScrollView.init()
        scrollView.frame = CGRect.init(x: 0, y: tabpage.frame.maxY, width: tabpage.frame.width, height: 400)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize.init(width: scrollView.frame.width * CGFloat(tabpage.dataSource.count), height: scrollView.frame.height)
        contentScrollView = scrollView
        
        view.addSubview(scrollView)
        for (index,item) in tabpage.dataSource.enumerated() {
            let subview = UIView.init(frame: CGRect.init(x: scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width, height: scrollView.frame.height))
            subview.backgroundColor = UIColor.randColor()
            
            let label = UILabel.init()
            label.text = item
            label.sizeToFit()
            label.center = CGPoint.init(x: subview.bounds.width/2.0, y: subview.bounds.height/2.0)
            subview.addSubview(label)
            
            scrollView.addSubview(subview)
        }
        
        scrollView.contentOffset = CGPoint.init(x: CGFloat(tabpage.selectIndex) * scrollView.bounds.width, y: 0)
    }
    
    // MARK: - Action
    @objc func clickAction(sender: Any) -> Void {
        print("点击了按钮")
        TCMRoute.route(withTarget: "", routeStyle: TCMRouteStyle.pop, params: ["info":"返回参数gg"])
    }

}

extension SwiftController {
    //MARK: - TCMRouteProtocol
    override static func route(withParams params: [String : Any]?) -> UIViewController & TCMRouteProtocol {
        print("传递参数：",params!)
        
        let vc = SwiftController()
        vc.label.text = params!["pp"] as? String
        return vc
    }
}

extension  SwiftController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = offsetX/scrollView.bounds.width
        tabpage.selectIndex = NSInteger(index)
    }
}

extension  SwiftController: ZJTabPageViewDelegate {
    
   public func tabPageView(_ pageView:ZJTabPageView, didSelectIndex index: NSInteger){
    print("oxoxoxox")
    contentScrollView.setContentOffset(CGPoint.init(x: contentScrollView.bounds.width * CGFloat(index), y: 0), animated: true)
    
    }
}
