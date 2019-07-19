//
//  CenterViewController.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/19.
//

import UIKit
import TCMBase

class CenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
}

extension CenterViewController {
    //MARK: - TCMRouteProtocol
    override static func route(withParams params: [String : Any]?) -> UIViewController & TCMRouteProtocol {
        print(params!)
        return CenterViewController()
    }
}
