//
//  VersonViewController.swift
//  Arita
//
//  Created by DcBunny on 15/8/18.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit

class VersonViewController: UIViewController
{
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - event response
    @IBAction func backToSetting() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
