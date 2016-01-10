//
//  TuCaoViewController.swift
//  Arita
//
//  Created by DcBunny on 15/10/20.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit

class TuCaoViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var tucaoWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid")
        let url = NSURL(string: "http://112.74.192.226/ios/tucao?uid=\(uid!)")
        let request = NSURLRequest(URL: url!)
        self.tucaoWebView.loadRequest(request)
        self.tucaoWebView.delegate = self
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
