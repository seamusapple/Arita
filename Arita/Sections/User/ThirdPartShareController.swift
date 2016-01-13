//
//  ThirdPartShareController.swift
//  Arita
//
//  Created by DcBunny on 15/9/10.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire

class ThirdPartShareController: UIViewController
{
    var articleJson: JSON = ""
    var articleUrl = NSURL()
    var shareType: Int!
    
    let alphaView = UIView()
    let baseView = UIView()
    let tapGesture = UITapGestureRecognizer()
    
    let label1 = UILabel()
    let wxFriendBtn = UIButton()
    let wxQuanBtn = UIButton()
    let wbBtn = UIButton()
    let qqFriendBtn = UIButton()
    let qqZoneBtn = UIButton()
    let copyBtn = UIButton()
    let wxFriendLabel = UILabel()
    let wxQuanLabel = UILabel()
    let wbLabel = UILabel()
    let qqFriendLabel = UILabel()
    let qqZoneLabel = UILabel()
    let copyLabel = UILabel()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.alphaView)
        self.view.addSubview(self.baseView)
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(self.label1)
        self.view.addSubview(self.wxFriendBtn)
        self.view.addSubview(self.wxQuanBtn)
        self.view.addSubview(self.wbBtn)
        self.view.addSubview(self.qqFriendBtn)
        self.view.addSubview(self.qqZoneBtn)
        self.view.addSubview(self.copyBtn)
        self.view.addSubview(self.wxFriendLabel)
        self.view.addSubview(self.wxQuanLabel)
        self.view.addSubview(self.wbLabel)
        self.view.addSubview(self.qqFriendLabel)
        self.view.addSubview(self.qqZoneLabel)
        self.view.addSubview(self.copyLabel)
        
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
        
        self.wxFriendBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label1.snp_bottom).offset(50)
            make.left.equalTo(self.view).offset(40)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.wxQuanBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label1.snp_bottom).offset(50)
            make.left.equalTo(self.wxFriendBtn.snp_right).offset(30)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.wbBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label1.snp_bottom).offset(50)
            make.left.equalTo(self.wxQuanBtn.snp_right).offset(30)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.wxFriendLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wxFriendBtn.snp_bottom).offset(10)
            make.left.equalTo(self.wxFriendBtn)
            make.size.equalTo(CGSizeMake(60, 14))
        }
        
        self.wxQuanLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wxQuanBtn.snp_bottom).offset(10)
            make.left.equalTo(self.wxQuanBtn).offset(-5)
            make.size.equalTo(CGSizeMake(70, 14))
        }
        
        self.wbLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wbBtn.snp_bottom).offset(10)
            make.left.equalTo(self.wbBtn)
            make.size.equalTo(CGSizeMake(60, 14))
        }
        
        self.qqFriendBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wxFriendLabel.snp_bottom).offset(30)
            make.left.equalTo(self.view).offset(40)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.qqZoneBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wxQuanLabel.snp_bottom).offset(30)
            make.left.equalTo(self.qqFriendBtn.snp_right).offset(30)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.copyBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.wbLabel.snp_bottom).offset(30)
            make.left.equalTo(self.qqZoneBtn.snp_right).offset(30)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        self.qqFriendLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.qqFriendBtn.snp_bottom).offset(10)
            make.left.equalTo(self.qqFriendBtn)
            make.size.equalTo(CGSizeMake(60, 14))
        }
        
        self.qqZoneLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.qqZoneBtn.snp_bottom).offset(10)
            make.left.equalTo(self.qqZoneBtn)
            make.size.equalTo(CGSizeMake(60, 14))
        }
        
        self.copyLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.copyBtn.snp_bottom).offset(10)
            make.left.equalTo(self.copyBtn)
            make.size.equalTo(CGSizeMake(60, 14))
        }
    }
    
    func setupPageSubviews() {
        self.view.backgroundColor = UIColor.clearColor()
        self.alphaView.backgroundColor = UIColor.clearColor()
        self.baseView.backgroundColor = UIColor.blackColor()
        self.baseView.alpha = 0.85
        
        self.label1.text = "分享你的视野"
        self.label1.font = UIFont.systemFontOfSize(20)
        self.label1.textColor = UIColor.whiteColor()
        self.label1.textAlignment = NSTextAlignment.Center
        
        self.wxFriendLabel.text = "微信好友"
        self.wxFriendLabel.font = UIFont.systemFontOfSize(14)
        self.wxFriendLabel.textColor = UIColor.whiteColor()
        self.wxFriendLabel.textAlignment = NSTextAlignment.Center
        
        self.wxQuanLabel.text = "微信朋友圈"
        self.wxQuanLabel.font = UIFont.systemFontOfSize(14)
        self.wxQuanLabel.textColor = UIColor.whiteColor()
        self.wxQuanLabel.textAlignment = NSTextAlignment.Center
        
        self.wbLabel.text = "新浪微博"
        self.wbLabel.font = UIFont.systemFontOfSize(14)
        self.wbLabel.textColor = UIColor.whiteColor()
        self.wbLabel.textAlignment = NSTextAlignment.Center
        
        self.qqFriendLabel.text = "QQ好友"
        self.qqFriendLabel.font = UIFont.systemFontOfSize(14)
        self.qqFriendLabel.textColor = UIColor.whiteColor()
        self.qqFriendLabel.textAlignment = NSTextAlignment.Center
        
        self.qqZoneLabel.text = "QQ空间"
        self.qqZoneLabel.font = UIFont.systemFontOfSize(14)
        self.qqZoneLabel.textColor = UIColor.whiteColor()
        self.qqZoneLabel.textAlignment = NSTextAlignment.Center
        
        self.copyLabel.text = "复制链接"
        self.copyLabel.font = UIFont.systemFontOfSize(14)
        self.copyLabel.textColor = UIColor.whiteColor()
        self.copyLabel.textAlignment = NSTextAlignment.Center
        
        self.wxFriendBtn.setImage(UIImage(named: "share_weixin"), forState: UIControlState.Normal)
        self.wxFriendBtn.tag = 0
        
        self.wxQuanBtn.setImage(UIImage(named: "share_pengyouquan"), forState: UIControlState.Normal)
        self.wxQuanBtn.tag = 1
        
        self.wbBtn.setImage(UIImage(named: "share_weibo"), forState: UIControlState.Normal)
        self.wbBtn.tag = 2
        
        self.qqFriendBtn.setImage(UIImage(named: "share_qq"), forState: UIControlState.Normal)
        self.qqFriendBtn.tag = 3
        
        self.qqZoneBtn.setImage(UIImage(named: "share_kongjian"), forState: UIControlState.Normal)
        self.qqZoneBtn.tag = 4
        
        self.copyBtn.setImage(UIImage(named: "share_link"), forState: UIControlState.Normal)
        self.copyBtn.tag = 5
    }
    
    //MARK: page subviews setting
    func setPageSubviewsEvent() {
        self.tapGesture.addTarget(self, action: Selector("goBackToAlarmList"))
        self.wxFriendBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.wxQuanBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.wbBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.qqFriendBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.qqZoneBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.copyBtn.addTarget(self, action: Selector("share:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK: - event response
    func goBackToAlarmList() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func share(button: UIButton) {
        var shareType: SSDKPlatformType?
        var contentType: SSDKContentType = SSDKContentType.WebPage
        var shareTitle = ""
        
        switch button.tag {
        case 0:
            shareType = SSDKPlatformType.SubTypeWechatSession
            
        case 1:
            shareType = SSDKPlatformType.SubTypeWechatTimeline
            
        case 2:
            shareType = SSDKPlatformType.TypeSinaWeibo
            contentType = SSDKContentType.Image
            shareTitle = self.articleJson["title"].stringValue
            shareTitle += "  "
            shareTitle += self.articleUrl.absoluteString
            
        case 3:
            shareType = SSDKPlatformType.SubTypeQQFriend
            
        case 4:
            shareType = SSDKPlatformType.SubTypeQZone
            
        case 5:
            shareType = SSDKPlatformType.TypeCopy
            
        default:
            break
        }

        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText(shareTitle,
            images: NSURL(string: self.articleJson["thumb_path"].stringValue),
            url: self.articleUrl,
            title: self.articleJson["title"].stringValue,
            type: contentType)

        //2.进行分享
        ShareSDK.share(shareType!, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
            
            switch state {
            case SSDKResponseState.Success:
                if shareType == SSDKPlatformType.TypeCopy {
                    let alert = UIAlertView(title: "", message: "链接已复制", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                }
                
                if shareType == SSDKPlatformType.TypeSinaWeibo {
                    let alert = UIAlertView(title: "", message: "分享成功", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    
                    var url = ""
                    var parameters: [String: String]!
                    if self.shareType == 0 {
                        url = "http://112.74.192.226/ios/add_article_recommend"
                        parameters = ["articleID": self.articleJson["ID"].stringValue]
                    } else {
                        url = "http://112.74.192.226/ios/add_goods_recommend"
                        parameters = ["goodsID": self.articleJson["ID"].stringValue]
                    }
                    
                    Alamofire.request(.GET, url, parameters: parameters)
                        .response { request, _, aJson, error in
                            _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
                    }
                }
                
                self.dismissViewControllerAnimated(true, completion: {})
                
            case SSDKResponseState.Fail:
                print("分享失败,错误描述:\(error)")
                
            case SSDKResponseState.Cancel:
                print("分享取消")
                
            default:
                break
            }
        }
    }
}
