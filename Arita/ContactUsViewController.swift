//
//  ContactUsViewController.swift
//  Arita
//
//  Created by DcBunny on 15/10/20.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, UIWebViewDelegate, MFMailComposeViewControllerDelegate
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contantUsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://112.74.192.226/ios/tucao_list")
        let request = NSURLRequest(URL: url!)
        self.contantUsWebView.loadRequest(request)
        self.contantUsWebView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    @IBAction func backToSetting(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func sendBug(sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["help@arita.com"])
        mailComposerVC.setSubject("Arita-Bug反馈")
        mailComposerVC.setMessageBody("（请在此添加Bug描述!）>>>>>>>>>>>>>>>>>>>>>", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "", message: "请先设置邮件账户", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
