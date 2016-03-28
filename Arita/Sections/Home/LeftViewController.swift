//
//  LeftViewController.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/11.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class LeftViewController: UIViewController, UIAlertViewDelegate
{
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var userState: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginDate: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutIcon: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutBtn: UIButton!
    
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactIcon: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactBtn: UIButton!
    
    @IBOutlet weak var versonView: UIView!
    @IBOutlet weak var versonIcon: UIImageView!
    @IBOutlet weak var versonLabel: UILabel!
    @IBOutlet weak var versonBtn: UIButton!

    @IBOutlet weak var quitView: UIView!
    @IBOutlet weak var quitIcon: UIImageView!
    @IBOutlet weak var quitLabel: UILabel!
    @IBOutlet weak var quitBtn: UIButton!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.frame = CGRectMake(0, 0, 320 * 0.78, Common.screenHeight)
        self.view.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
        self.userLogo.layer.masksToBounds = true
        self.userLogo.layer.cornerRadius = 55
        
        reloadView()
        
        self.infoBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.infoBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.infoBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.likeBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.likeBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.likeBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.aboutBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.aboutBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.aboutBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.contactBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.contactBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.contactBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.versonBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.versonBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.versonBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.quitBtn.addTarget(self, action: #selector(LeftViewController.onTouch(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.quitBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.quitBtn.addTarget(self, action: #selector(LeftViewController.offTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeftViewController.reloadView), name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeftViewController.reloadNickName), name: "ReloadNickName", object: nil)
    }
    
    func reloadNickName() {
        self.userName.text = NSUserDefaults.standardUserDefaults().stringForKey("nickname")
    }
    
    func reloadView() {
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("nickname")
        if userName != nil {
            self.loginDate.hidden = false
            self.quitView.hidden = false
            self.userName.hidden = false
            self.userState.hidden = true
            self.loginBtn.hidden = true
            self.userName.text = userName

            self.infoBtn.enabled = true
            self.likeBtn.enabled = true
            self.contactBtn.enabled = true
            
            let date: NSDate = NSDate()
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.stringFromDate(date)
            self.loginDate.text = dateString
            
            let imageUrl = NSUserDefaults.standardUserDefaults().stringForKey("usericon")
            self.userLogo.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "portrait"))
        } else {
            self.loginDate.hidden = true
            self.quitView.hidden = true
            self.userName.hidden = true
            self.userLogo.image = UIImage(named: "portrait")
            self.userState.hidden = false
            self.loginBtn.hidden = false
            
            self.infoBtn.enabled = false
            self.likeBtn.enabled = false
            self.contactBtn.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            print("取消")
        case 1:
            ShareSDK.cancelAuthorize(SSDKPlatformType.TypeAny)
            NSUserDefaults.standardUserDefaults().removeObjectForKey("nickname")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("usericon")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("gender")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("uid")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userid")
            
            NSNotificationCenter.defaultCenter().postNotificationName("UserLogout", object: nil)

            reloadView()
        default:
            break
        }
    }
    
    //MARK: - event response
    func onTouch(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.infoView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.infoIcon.image = UIImage(named: "person_current")
            self.infoLabel.textColor = UIColor.whiteColor()
            
        case 1:
            self.likeView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.likeIcon.image = UIImage(named: "collect_current")
            self.likeLabel.textColor = UIColor.whiteColor()
            
        case 2:
            self.aboutView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.aboutIcon.image = UIImage(named: "aboutUs_current")
            self.aboutLabel.textColor = UIColor.whiteColor()
            
        case 3:
            self.contactView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.contactIcon.image = UIImage(named: "contactUs_current")
            self.contactLabel.textColor = UIColor.whiteColor()
            
        case 4:
            self.versonView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.versonIcon.image = UIImage(named: "versions_current")
            self.versonLabel.textColor = UIColor.whiteColor()
            
        case 5:
            self.quitView.backgroundColor = UIColor(red: 28 / 255.0, green: 33 / 255.0, blue: 39 / 255.0, alpha: 1.0)
            self.quitIcon.image = UIImage(named: "quit_current")
            self.quitLabel.textColor = UIColor.whiteColor()
            
        default:
            break
        }
    }
    
    func offTouch(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.infoView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.infoIcon.image = UIImage(named: "person")
            self.infoLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        case 1:
            self.likeView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.likeIcon.image = UIImage(named: "collect")
            self.likeLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        case 2:
            self.aboutView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.aboutIcon.image = UIImage(named: "aboutUs")
            self.aboutLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        case 3:
            self.contactView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.contactIcon.image = UIImage(named: "contactUs")
            self.contactLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        case 4:
            self.versonView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.versonIcon.image = UIImage(named: "versions")
            self.versonLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        case 5:
            self.quitView.backgroundColor = UIColor(red: 37 / 255.0, green: 41 / 255.0, blue: 50 / 255.0, alpha: 1.0)
            self.quitIcon.image = UIImage(named: "quit")
            self.quitLabel.textColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            
        default:
            break
        }
    }
    
    @IBAction func userLogin(sender: UIButton) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartLoginController = ThirdPartLoginController()
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(thirdPartLoginController , animated:true, completion: nil)
        })
    }
    
    @IBAction func quit(sender: UIButton) {
        let alert = UIAlertView()
        alert.title = "退出 阿里塔"
        alert.delegate = self
        alert.addButtonWithTitle("取消")
        alert.addButtonWithTitle("确定")
        alert.show()
    }
}
