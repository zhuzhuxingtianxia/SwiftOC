//
//  ViewController.swift
//  HomeModuleDemo
//
//  Created by ZZJ on 2019/7/19.
//  Copyright © 2019 Jion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func method() {
        TCMRoute.route(withTarget: "HomeController", params: nil)
    }
}

