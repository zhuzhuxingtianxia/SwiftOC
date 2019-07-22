//
//  CenterViewController.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/19.
//

import UIKit
import TCMBase

class CenterViewController: UIViewController {
    
    fileprivate var headerIocn:UIImageView?
    
    fileprivate var userNameLabel:UILabel?
    
    fileprivate var redPackageItem: PackageItem?
    
    fileprivate var accountItem: PackageItem?
    
    let scrollView:UIScrollView = {
       let scroll = UIScrollView.init()
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        buildView()
    }
    
    func buildView() {
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        
        let headerMaxY = buildHeaderView()
        
        let orderCardMaxY = buildOrderCardView(y: headerMaxY)
        
        let pageViewMaxY = buildPageViewCard(y: orderCardMaxY)
        
        let commomViewMaxY = buildCommonView(y: pageViewMaxY)
        
        scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width, height: commomViewMaxY+10)
        
    }
    
    
}

extension CenterViewController {
    //MARK: - TCMRouteProtocol
    override static func route(withParams params: [String : Any]?) -> UIViewController & TCMRouteProtocol {
        let center = CenterViewController()
       
        return center
    }
}

//MARK: - method
extension CenterViewController {
    //设置按钮事件
    @objc func settingAction(){
        print("设置按钮被点击")
    }
    //登陆或查看用户信息
    @objc func userInfoAction(){
        print("登陆或查看用户信息")
    }
    
    @objc func jumpEvent(sender:UIControl){
        print("jumpEvent被点击")
    }
}

protocol CombProperties {
    
}

//MARK: BuildView
extension CenterViewController: CombProperties {
    
   fileprivate func buildHeaderView() -> CGFloat{
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: 205))
        let topBgImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: headerView.bounds.size.width, height: 170))
        topBgImg.image = UIImage.init(named: "bg", in: Bundle.init(for: CenterViewController.self), compatibleWith: nil)
        headerView.addSubview(topBgImg)
    
        let settingBtn = UIButton.init(type: UIButton.ButtonType.system)
        settingBtn.frame = CGRect.init(x: view.bounds.size.width-40-10, y: 30, width: 40, height: 40)
        settingBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        settingBtn.setTitle("设置", for: UIControl.State.normal)
        settingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        settingBtn.addTarget(self, action: #selector(settingAction), for: UIControl.Event.touchUpInside)
        headerView.addSubview(settingBtn)
    
       let redAccountViewMinY = buildRedAccountView(headerView: headerView)
    
        headerIocn = UIImageView.init()
        headerIocn?.isUserInteractionEnabled = true
        headerIocn?.frame = CGRect.init(x: 17, y: redAccountViewMinY-15-50, width: 50, height: 50)
        headerIocn?.image = UIImage.init(named: "canvas", in: Bundle.init(for: type(of: self)), compatibleWith: nil)
        headerIocn?.layer.cornerRadius = headerIocn!.frame.size.height/2.0
        headerIocn?.layer.masksToBounds = true
        headerView.addSubview(headerIocn!)
    
        let tapUserInfo = UITapGestureRecognizer.init(target: self, action: #selector(userInfoAction))
        headerIocn?.addGestureRecognizer(tapUserInfo)
    
        userNameLabel = UILabel.init()
        userNameLabel?.frame = CGRect.init(x: headerIocn!.frame.maxX+10, y: headerIocn!.frame.minY, width: 200, height: 40)
        userNameLabel?.font = UIFont.systemFont(ofSize: 22)
        userNameLabel?.textColor = UIColor.white
        userNameLabel?.text = "登陆"
        headerView.addSubview(userNameLabel!)
    
        let tapUserName = UITapGestureRecognizer.init(target: self, action: #selector(userInfoAction))
        userNameLabel?.addGestureRecognizer(tapUserName)
    
        scrollView.addSubview(headerView)
        
        return headerView.frame.maxY
    }
    
    private func buildRedAccountView(headerView: UIView)-> CGFloat {
        let topCardImg = UIImageView.init(frame: CGRect.init(x: 8, y: headerView.frame.size.height - 68 - 18, width: headerView.bounds.size.width-2*8, height: 68))
        topCardImg.isUserInteractionEnabled = true
        topCardImg.image = UIImage.init(named: "personal_cardbg", in: Bundle.init(for: type(of: self)), compatibleWith: nil)
        headerView.addSubview(topCardImg)
        
        let itemWidth = topCardImg.frame.size.width/5.0
        let itemHeight = topCardImg.frame.size.height - 20
        
        redPackageItem = PackageItem.init()
        redPackageItem?.tag = 1
        redPackageItem?.frame = CGRect.init(x: itemWidth, y: 10, width: itemWidth, height: itemHeight)
        redPackageItem?.topTitle = "0"
        redPackageItem?.bottomTitle = "红包卡券"
        redPackageItem?.addTarget(self, action: #selector(jumpEvent(sender:)), for: UIControl.Event.touchUpInside)
        topCardImg.addSubview(redPackageItem!)
        
        accountItem = PackageItem.init()
        accountItem?.tag = 2
        accountItem?.frame = CGRect.init(x: 3*itemWidth, y: 10, width: itemWidth, height: itemHeight)
        accountItem?.topTitle = "¥0.00"
        accountItem?.bottomTitle = "余额"
        accountItem?.addTarget(self, action: #selector(jumpEvent(sender:)), for: UIControl.Event.touchUpInside)
        topCardImg.addSubview(accountItem!)
        
        return topCardImg.frame.minY
    }
    
   fileprivate func buildOrderCardView(y: CGFloat)-> CGFloat {
        let orderCard = UIView.init()
        orderCard.frame = CGRect.init(x: 8, y: y, width: view.bounds.size.width-16, height: 0)
        orderCard.layer.cornerRadius = 10
        orderCard.backgroundColor = UIColor.white
        scrollView.addSubview(orderCard)
    
        let myOrderLabel = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 200, height: 35))
        myOrderLabel.font = UIFont.systemFont(ofSize: 15)
        myOrderLabel.textColor = UIColor.hexString(hex: "#333333")
        myOrderLabel.text = "我的订单"
        orderCard.addSubview(myOrderLabel)
    
        let checkAllButton = UIButton.init(type: UIButton.ButtonType.custom)
        checkAllButton.frame = CGRect.init(x: orderCard.frame.width-10-200, y: 0, width: 200, height: 35)
        checkAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        checkAllButton.setTitleColor(UIColor.hexString(hex: "#999999"), for: UIControl.State.normal)
        checkAllButton.contentHorizontalAlignment = .right
        checkAllButton.setTitle("查看全部订单 >", for: UIControl.State.normal)
        checkAllButton.tag = 3
        checkAllButton.addTarget(self, action: #selector(jumpEvent(sender:)), for: UIControl.Event.touchUpInside)
        orderCard.addSubview(checkAllButton)
    
        let separatorLine = UIView.init()
        separatorLine.frame = CGRect.init(x: 0, y: checkAllButton.frame.maxY, width: orderCard.frame.width, height: 1.0)
        separatorLine.backgroundColor = UIColor.hexString(hex: "#f5f2f2")
        orderCard.addSubview(separatorLine)
    
        let orderStateView = UIView.init()
        orderStateView.frame = CGRect.init(x: 0, y: separatorLine.frame.maxY+10, width: orderCard.frame.width, height: 60)
        orderCard.addSubview(orderStateView)
    
        let orderIocns = [["img":"obligations","title":"待付款"],
                      ["img":"consigment","title":"待发货"],
                      ["img":"unreceiptd","title":"待收货"],
                      ["img":"afterSales","title":"售后/退款"]]
        let orderItemWidth = (orderCard.frame.width-20)/CGFloat(orderIocns.count)
        for  (index,orderIcon) in orderIocns.enumerated() {
            let orderItem = UIButton.init(type: UIButton.ButtonType.system)
            orderItem.frame = CGRect.init(x: 10+CGFloat (index)*orderItemWidth, y: 0, width: orderItemWidth, height: orderStateView.frame.height)
            orderItem.setTitleColor(UIColor.hexString(hex: "#666666"), for: UIControl.State.normal)
            orderItem.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            orderItem.setTitle(orderIcon["title"], for: UIControl.State.normal)
            let image = UIImage.init(named: orderIcon["img"]!, in: Bundle.init(for: type(of: self)), compatibleWith: nil)
            orderItem.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
            orderItem.layoutButton(style: .Top, space: 8)
            
            orderStateView.addSubview(orderItem)
            
        }
    
        //物流信息
        let logisticsCard = UIView.init()
        logisticsCard.frame = CGRect.init(x: 15, y: orderStateView.frame.maxY+10, width: orderCard.frame.width-30, height: 75)
        logisticsCard.backgroundColor = UIColor.hexString(hex: "#f6f6f6")
        logisticsCard.layer.cornerRadius = 10
        orderCard.addSubview(logisticsCard)
    
        let lastView = logisticsCard
    
        let newFrame = CGRect(origin: orderCard.frame.origin, size: CGSize.init(width: orderCard.frame.size.width, height: lastView.frame.maxY+20))
        orderCard.frame = newFrame
    
        return orderCard.frame.maxY
    }
    
   fileprivate func buildPageViewCard(y:CGFloat) -> CGFloat {
        let pageView = UIView.init(frame: CGRect.init(x: 8, y: y+10, width: view.frame.size.width-16, height: 140))
        pageView.backgroundColor = UIColor.init(red: 254/255.0, green: 219/255.0, blue: 227/255.0, alpha: 1.0)
        
        scrollView.addSubview(pageView)
        
        return pageView.frame.maxY
    }
    
   fileprivate func buildCommonView(y:CGFloat) -> CGFloat {
        let commonView = UIView.init(frame: CGRect.init(x: 8, y: y+10, width: view.frame.size.width-16, height: 123))
        commonView.layer.cornerRadius = 10
        commonView.backgroundColor = UIColor.white
        scrollView.addSubview(commonView)
    
        let commonLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 200, height: 50))
        commonLabel.font = UIFont.systemFont(ofSize: 15)
        commonLabel.textColor = UIColor.hexString(hex: "#333333")
        commonLabel.text = "常用功能"
        commonView.addSubview(commonLabel)
    
        let separatorLine = UIView.init()
        separatorLine.frame = CGRect.init(x: 0, y: commonLabel.frame.maxY, width: commonView.frame.width, height: 1.0)
        separatorLine.backgroundColor = UIColor.hexString(hex: "#f5f2f2")
        commonView.addSubview(separatorLine)
    
        let models = [["img":"exchangeCard","title":"兑换"],
                      ["img":"balance","title":"充值"],
                      ["img":"addressCard","title":"地址"],
                      ["img":"customerService","title":"客服"],
                      ["img":"welfare","title":"企业福利"]]
        let itemWidth = commonView.frame.width/CGFloat(models.count)
    
        for  (index,model) in models.enumerated() {
            let item = UIButton.init(type: UIButton.ButtonType.system)
            item.frame = CGRect.init(x: CGFloat (index)*itemWidth, y: separatorLine.frame.maxY+10, width: itemWidth, height: 60)
            item.setTitleColor(UIColor.hexString(hex: "#333333", alpha: 0.7), for: UIControl.State.normal)
            item.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            item.setTitle(model["title"], for: UIControl.State.normal)
            let image = UIImage.init(named: model["img"]!, in: Bundle.init(for: type(of: self)), compatibleWith: nil)
        item.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
            item.layoutButton(style: .Top, space: 8)
            
            commonView.addSubview(item)
            
        }
        
        return commonView.frame.maxY
    }
    
}

