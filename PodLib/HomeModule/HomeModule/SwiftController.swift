//
//  SwiftController.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/19.
//

import UIKit
import TCMBase

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(imgView)
        
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
