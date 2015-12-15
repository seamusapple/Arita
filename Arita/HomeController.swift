//
//  ViewController.swift
//  Arita
//
//  Created by DcBunny on 15/7/20.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HomeController: UIViewController
{
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var tataBtn: UIButton!
    @IBOutlet weak var cyBtn: UIButton!
    @IBOutlet weak var sjBtn: UIButton!
    @IBOutlet weak var shBtn: UIButton!
    @IBOutlet weak var lpBtn: UIButton!
    
    @IBOutlet weak var tataImage: UIImageView!
    @IBOutlet weak var cyImage: UIImageView!
    @IBOutlet weak var sjImage: UIImageView!
    @IBOutlet weak var shImage: UIImageView!
    @IBOutlet weak var lpImage1: UIImageView!
    @IBOutlet weak var lpImage2: UIImageView!
    @IBOutlet weak var lpImage3: UIImageView!
    
    @IBOutlet weak var tataTitle: UILabel!
    @IBOutlet weak var cyTitle: UILabel!
    @IBOutlet weak var sjTitle: UILabel!
    @IBOutlet weak var shTitle: UILabel!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_indexdata")
            .responseJSON { _, _, aJson in
                self.getHomeInfo(aJson.value)
            }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideLoginBtn", name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLoginBtn", name: "UserLogout", object: nil)
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - event response
    @IBAction func menuBtnClicked() {
        
//        println("Menu button clicked.")
    }
    
    @IBAction func userLogin() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartLoginController = ThirdPartLoginController()
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(thirdPartLoginController , animated:true, completion: nil)
        })
    }
    
    @IBAction func tataBtnClicked(sender: UIButton) {
        
        _ = sender.tag
    }
    
    // segue 跳转传参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let segueId = segue.identifier
        if segueId == "cySegue" || segueId == "sjSegue" || segueId == "shSegue" {
            let destinationController = segue.destinationViewController as! InterestingController
            destinationController.segueId = segueId!
        }
    }
    
    func hideLoginBtn() {
        self.loginBtn.hidden = true
    }
    
    func showLoginBtn() {
        self.loginBtn.hidden = false
    }
    
    //MARK: - private methods
    func isUserLogin() -> Bool {
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            return true
        } else {
            return false
        }
    }
    
    func getHomeInfo(data: AnyObject?) {
        let jsonString = JSON(data!)
        var imageArray = [String]()
        for (_, subJson): (String, JSON) in jsonString {
            let categoryId = subJson["category_ID"].string
            let title = subJson["title"].string
            let imageUrl = subJson["thumb_path"].string
            switch categoryId! {
            case "1":
                self.tataTitle.text = title
                self.tataImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
                
            case "2":
                self.cyTitle.text = title
                self.cyImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
                
            case "3":
                self.shTitle.text = title
                self.shImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
                
            case "4":
                self.sjTitle.text = title
                self.sjImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
                
            case "5":
                imageArray.append(subJson["thumb_path"].string!)
                continue
                
            default:
                break
            }
        }
        var index = 0
        for image in imageArray {
            ++index
            switch index {
            case 1:
                self.lpImage1.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: nil)
                
            case 2:
                self.lpImage2.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: nil)
                
            case 3:
                self.lpImage3.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: nil)
                
            default:
                break
            }
        }
    }
}

