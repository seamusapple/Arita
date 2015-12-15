//
//  AlarmContentViewController.swift
//  IOTeamAlarm
//
//  Created by DcBunny on 15/9/9.
//  Copyright (c) 2015年 IOTeam. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ThirdPartLoginController: UIViewController
{
    let alphaView = UIView()
    let baseView = UIView()
    let tapGesture = UITapGestureRecognizer()
    let label1 = UILabel()
    let label2 = UILabel()
    let wbBtn = UIButton()
    let qqBtn = UIButton()
    let wxBtn = UIButton()

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.alphaView)
        self.view.addSubview(self.baseView)
        self.view.addGestureRecognizer(tapGesture)
        self.view.addSubview(self.label1)
        self.view.addSubview(self.label2)
        self.view.addSubview(self.wbBtn)
        self.view.addSubview(self.qqBtn)
        self.view.addSubview(self.wxBtn)
        
        layoutPageSubviews()
        setupPageSubviews()
        setPageSubviewsEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - layout methods
    func layoutPageSubviews() {
        self.alphaView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(0)
        }
        
        self.baseView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(0)
        }
        
        self.label1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(20)
        }
        
        self.label2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label1.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(20)
        }
        
        self.wbBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label2.snp_bottom).offset(30)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(60)
        }
        
        self.qqBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wbBtn.snp_bottom).offset(15)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(60)
        }
        
        self.wxBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.qqBtn.snp_bottom).offset(15)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(60)
        }
    }
    
    func setupPageSubviews() {
        self.view.backgroundColor = UIColor.clearColor()
        self.alphaView.backgroundColor = UIColor.clearColor()
        self.baseView.backgroundColor = UIColor.blackColor()
        self.baseView.alpha = 0.85
        
        self.label1.text = "登录阿里塔"
        self.label1.font = UIFont.systemFontOfSize(20)
        self.label1.textColor = UIColor.whiteColor()
        self.label1.textAlignment = NSTextAlignment.Center
        
        self.label2.text = "你可以选择以下方式登录"
        self.label2.font = UIFont.systemFontOfSize(14)
        self.label2.textColor = UIColor.whiteColor()
        self.label2.textAlignment = NSTextAlignment.Center
        
        self.wbBtn.setImage(UIImage(named: "register_weibo"), forState: UIControlState.Normal)
        self.wbBtn.tag = 0
        
        self.qqBtn.setImage(UIImage(named: "register_qq"), forState: UIControlState.Normal)
        self.qqBtn.tag = 1
        
        self.wxBtn.setImage(UIImage(named: "register_weixin"), forState: UIControlState.Normal)
        self.wxBtn.tag = 2
    }
    
    //MARK: page subviews setting
    func setPageSubviewsEvent() {
        self.tapGesture.addTarget(self, action: Selector("goBackToAlarmList"))
        self.wbBtn.addTarget(self, action: Selector("login:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.qqBtn.addTarget(self, action: Selector("login:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.wxBtn.addTarget(self, action: Selector("login:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK: - event response
    func goBackToAlarmList() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func login(button: UIButton) {
        switch button.tag {
        case 0:
            self.dismissViewControllerAnimated(true, completion: {})
            //授权
            ShareSDK.authorize(SSDKPlatformType.TypeSinaWeibo, settings: nil, onStateChanged: { (state : SSDKResponseState, user : SSDKUser!, error : NSError!) -> Void in
                
                switch state{
                    
                case SSDKResponseState.Success:
                    let nickName = user.nickname.stringByRemovingPercentEncoding
                    let userIcon = user.rawData["avatar_large"] as! String
                    let gender = user.gender.hashValue
                    NSUserDefaults.standardUserDefaults().setValue(nickName, forKey: "nickname")
                    NSUserDefaults.standardUserDefaults().setValue(userIcon, forKey: "usericon")
                    NSUserDefaults.standardUserDefaults().setValue(gender, forKey: "gender")
                    NSUserDefaults.standardUserDefaults().setValue(user.uid, forKey: "uid")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    let parameters = [
                        "thirdType": 0,
                        "uid": user.uid,
                        "nickname": nickName!,
                        "gender": gender,
                        "headimgurl": userIcon
                    ]
                    Alamofire.request(.POST, "http://112.74.192.226/ios/update_user", parameters: parameters as? [String : AnyObject])
                        .response { _, _, data, error in
                            let userId = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "userid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("UserLogin", object: nil)
                    }
                    
                case SSDKResponseState.Fail:
                    print("授权失败,错误描述:\(error)")
                    
                case SSDKResponseState.Cancel:
                    print("操作取消")
                    
                default:
                    break
                }
            })
        case 1:
            self.dismissViewControllerAnimated(true, completion: {})
            //授权
            ShareSDK.authorize(SSDKPlatformType.TypeQQ, settings: nil, onStateChanged: { (state : SSDKResponseState, user : SSDKUser!, error : NSError!) -> Void in
                
                switch state{
                    
                case SSDKResponseState.Success:
                    let nickName = user.nickname.stringByRemovingPercentEncoding
                    let userIcon = user.rawData["figureurl_qq_2"] as! String
                    let gender = user.gender.hashValue
                    NSUserDefaults.standardUserDefaults().setValue(nickName, forKey: "nickname")
                    NSUserDefaults.standardUserDefaults().setValue(userIcon, forKey: "usericon")
                    NSUserDefaults.standardUserDefaults().setValue(gender, forKey: "gender")
                    NSUserDefaults.standardUserDefaults().setValue(user.uid, forKey: "uid")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    let parameters = [
                        "thirdType": 1,
                        "uid": user.uid,
                        "nickname": nickName!,
                        "gender": gender,
                        "headimgurl": userIcon
                    ]
                    Alamofire.request(.GET, "http://112.74.192.226/ios/update_user", parameters: parameters as? [String : AnyObject])
                        .response { _, _, data, error in
                            let userId = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "userid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("UserLogin", object: nil)
                    }
                    
                case SSDKResponseState.Fail:
                    print("授权失败,错误描述:\(error)")
                    
                case SSDKResponseState.Cancel:
                    print("操作取消")
                    
                default:
                    break
                }
            })
        case 2:
            self.dismissViewControllerAnimated(true, completion: {})
            //授权
            ShareSDK.authorize(SSDKPlatformType.TypeWechat, settings: nil, onStateChanged: { (state : SSDKResponseState, user : SSDKUser!, error : NSError!) -> Void in
                
                switch state{
                    
                case SSDKResponseState.Success:
                    let nickName = user.nickname.stringByRemovingPercentEncoding
                    let userIcon = user.icon
                    let gender = user.gender.hashValue
                    NSUserDefaults.standardUserDefaults().setValue(nickName, forKey: "nickname")
                    NSUserDefaults.standardUserDefaults().setValue(userIcon, forKey: "usericon")
                    NSUserDefaults.standardUserDefaults().setValue(gender, forKey: "gender")
                    NSUserDefaults.standardUserDefaults().setValue(user.uid, forKey: "uid")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    let parameters = [
                        "thirdType": 2,
                        "uid": user.uid,
                        "nickname": nickName!,
                        "gender": gender,
                        "headimgurl": userIcon
                    ]
                    Alamofire.request(.GET, "http://112.74.192.226/ios/update_user", parameters: parameters as? [String : AnyObject])
                        .response { _, _, data, error in
                            let userId = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "userid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("UserLogin", object: nil)
                    }
                    
                case SSDKResponseState.Fail:
                    print("授权失败,错误描述:\(error)")
                    
                case SSDKResponseState.Cancel:
                    print("操作取消")
                    
                default:
                    break
                }
            })
        default:
            break
        }
    }
}
