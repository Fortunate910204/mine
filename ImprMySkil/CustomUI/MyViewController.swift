//
//  MyViewController.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/25.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    var isSVProgressView = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        isSVProgressView = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isSVProgressView = true
    }
    
}
