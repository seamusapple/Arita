//
//  TouGaoViewController.swift
//  Arita
//
//  Created by DcBunny on 15/10/20.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit

class TouGaoViewController: UIViewController
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
    
    @IBAction func backToContact(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
