//
//  HomeViewController.swift
//  Arita
//
//  Created by DcBunny on 15/12/18.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HomeViewController: UIViewController
{
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var menuBtn = UIButton()
    var loginBtn = UIButton()
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var tataView = UIView()
    var tataImage = UIImageView()
    var tataLabel = UIImageView()
    var tataBtn = UIButton()
    
    var cyView = UIView()
    var cyImage1 = UIImageView()
    var cyImage2 = UIImageView()
    var cyImage3 = UIImageView()
    var cyLabel = UIImageView()
    var cyBtn = UIButton()
    
    var sjView = UIView()
    var sjImage1 = UIImageView()
    var sjImage2 = UIImageView()
    var sjImage3 = UIImageView()
    var sjLabel = UIImageView()
    var sjBtn = UIButton()
    
    var shView = UIView()
    var shImage1 = UIImageView()
    var shImage2 = UIImageView()
    var shImage3 = UIImageView()
    var shLabel = UIImageView()
    var shBtn = UIButton()
    
    var lpView = UIView()
    var lpImage1 = UIImageView()
    var lpImage2 = UIImageView()
    var lpImage3 = UIImageView()
    var lpLabel = UIImageView()
    var lpBtn1 = UIButton()
    var lpBtn2 = UIButton()
    var lpBtn3 = UIButton()
    
    private let width = SCREEN_WIDTH - 20
    private let height = (SCREEN_WIDTH - 20) * 2 / 3
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initComponents()
        self.addPageSubviews()
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setPageEvents()
        self.loadDataFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("HomeViewController memory waring.")
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - init methods
    func initComponents() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideLoginBtn", name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLoginBtn", name: "UserLogout", object: nil)
    }
    
    func addPageSubviews() {
        self.view.addSubview(self.titleView)
        self.titleView.addSubview(self.titleViewBg)
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.menuBtn)
        self.titleView.addSubview(self.loginBtn)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.tataView)
        self.tataView.addSubview(self.tataImage)
        self.tataView.addSubview(self.tataLabel)
        self.tataView.addSubview(self.tataBtn)
        
        self.contentView.addSubview(self.cyView)
        self.cyView.addSubview(self.cyImage1)
        self.cyView.addSubview(self.cyImage2)
        self.cyView.addSubview(self.cyImage3)
        self.cyView.addSubview(self.cyLabel)
        self.cyView.addSubview(self.cyBtn)
        
        self.contentView.addSubview(self.sjView)
        self.sjView.addSubview(self.sjImage1)
        self.sjView.addSubview(self.sjImage2)
        self.sjView.addSubview(self.sjImage3)
        self.sjView.addSubview(self.sjLabel)
        self.sjView.addSubview(self.sjBtn)
        
        self.contentView.addSubview(self.shView)
        self.shView.addSubview(self.shImage1)
        self.shView.addSubview(self.shImage2)
        self.shView.addSubview(self.shImage3)
        self.shView.addSubview(self.shLabel)
        self.shView.addSubview(self.shBtn)
        
        self.contentView.addSubview(self.lpView)
        self.lpView.addSubview(self.lpImage1)
        self.lpView.addSubview(self.lpImage2)
        self.lpView.addSubview(self.lpImage3)
        self.lpView.addSubview(self.lpLabel)
        self.lpView.addSubview(self.lpBtn1)
        self.lpView.addSubview(self.lpBtn2)
        self.lpView.addSubview(self.lpBtn3)
    }
    
    // MARK: - layout and set page subviews
    func layoutPageSubviews() {
        self.titleView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(35)
        }
        
        self.titleViewBg.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.titleView)
        }
        
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.titleView)
            make.size.equalTo(CGSizeMake(50, 20))
        }
        
        self.menuBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.titleView).offset(10)
            make.centerY.equalTo(self.titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        self.loginBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.titleView).offset(-10)
            make.centerY.equalTo(self.titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.edges.equalTo(self.scrollView).inset(0)
        }
        
        self.tataView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.tataImage.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.tataView)
        }
        
        self.tataLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tataView)
            make.left.equalTo(self.tataView).offset(10)
            make.size.equalTo(CGSizeMake(45, 22))
        }
        
        self.tataBtn.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.tataView)
        }
        
        self.cyView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tataView.snp_bottom).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.cyImage1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cyView)
            make.right.equalTo(self.cyImage3.snp_left).offset(-5)
            make.height.equalTo(self.cyImage1.snp_width)
        }
        
        self.cyImage2.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(self.cyView)
            make.top.equalTo(self.cyImage1.snp_bottom).offset(5)
            make.right.equalTo(self.cyImage1)
        }
        
        self.cyImage3.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(self.cyView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
        self.cyLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.cyView)
            make.right.equalTo(self.cyView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.cyBtn.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.cyView)
        }
        
        self.sjView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.cyView.snp_bottom).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.sjImage1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.sjView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
        self.sjImage2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.sjImage1.snp_right).offset(5)
            make.top.right.equalTo(self.sjView)
            make.height.equalTo(self.sjImage2.snp_width)
        }
        
        self.sjImage3.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self.sjView)
            make.top.equalTo(self.sjImage2.snp_bottom).offset(5)
            make.left.equalTo(self.sjImage2)
        }
        
        self.sjLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.sjView)
            make.left.equalTo(self.sjView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.sjBtn.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.sjView)
        }
        
        self.shView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.sjView.snp_bottom).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.shImage1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.shView)
            make.right.equalTo(self.shImage3.snp_left).offset(-5)
            make.height.equalTo(self.shImage1.snp_width)
        }
        
        self.shImage2.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(self.shView)
            make.top.equalTo(self.shImage1.snp_bottom).offset(5)
            make.right.equalTo(self.shImage1)
        }
        
        self.shImage3.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(self.shView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
        self.shLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.shView)
            make.right.equalTo(self.shView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.shBtn.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.shView)
        }
        
        self.lpView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.shView.snp_bottom).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.lpImage1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.lpView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
        self.lpImage2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.lpImage1.snp_right).offset(5)
            make.top.right.equalTo(self.lpView)
            make.height.equalTo(self.lpImage2.snp_width)
        }
        
        self.lpImage3.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self.lpView)
            make.top.equalTo(self.lpImage2.snp_bottom).offset(5)
            make.left.equalTo(self.lpImage2)
        }
        
        self.lpLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.lpView)
            make.left.equalTo(self.lpView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.lpBtn1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpImage1)
        }
        
        self.lpBtn2.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpImage2)
        }
        
        self.lpBtn3.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpImage3)
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleViewBg.image = UIImage(named: "homeTitle")
        self.titleLabel.text = "阿里塔"
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = COLOR_TATA
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.menuBtn.setBackgroundImage(UIImage(named: "menuBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "userBtn"), forState: UIControlState.Normal)
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.tataLabel.image = UIImage(named: "tataLabel")
        
        self.cyLabel.image = UIImage(named: "cyLabel")
        
        self.sjLabel.image = UIImage(named: "sjLabel")
        
        self.shLabel.image = UIImage(named: "shLabel")
        
        self.lpLabel.image = UIImage(named: "lpLable")
        
        self.lpBtn1.tag = 0
        self.lpBtn2.tag = 1
        self.lpBtn3.tag = 2
    }
    
    // MARK: - set events
    func setPageEvents() {
        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.tataBtn.addTarget(self, action: Selector("goTata"), forControlEvents: UIControlEvents.TouchUpInside)
        self.cyBtn.addTarget(self, action: Selector("goCy"), forControlEvents: UIControlEvents.TouchUpInside)
        self.sjBtn.addTarget(self, action: Selector("goSj"), forControlEvents: UIControlEvents.TouchUpInside)
        self.shBtn.addTarget(self, action: Selector("goSh"), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn1.addTarget(self, action: Selector("goLp:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn2.addTarget(self, action: Selector("goLp:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn3.addTarget(self, action: Selector("goLp:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_indexdata2")
            .responseJSON { _, _, aJson in
                self.getHomeInfo(aJson.value)
        }
    }
    
    // MARK: - event response
    func userLogin() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartLoginController = ThirdPartLoginController()
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.view.window!.rootViewController!.presentViewController(thirdPartLoginController , animated:true, completion: nil)
        })
    }
    
    func hideLoginBtn() {
        self.loginBtn.hidden = true
    }
    
    func showLoginBtn() {
        self.loginBtn.hidden = false
    }
    
    func goTata() {
        let tata = TataViewController()
        self.view.window!.rootViewController!.presentViewController(tata, animated: true, completion: nil)
    }
    
    func goCy() {
        let cy = ArticleViewController()
        cy.segueId = "cySegue"
        self.view.window!.rootViewController!.presentViewController(cy, animated: true, completion: nil)
    }
    
    func goSj() {
        let sj = ArticleViewController()
        sj.segueId = "sjSegue"
        self.view.window!.rootViewController!.presentViewController(sj, animated: true, completion: nil)
    }
    
    func goSh() {
        let sh = ArticleViewController()
        sh.segueId = "shSegue"
        self.view.window!.rootViewController!.presentViewController(sh, animated: true, completion: nil)
    }
    
    func goLp(sender: UIButton) {
//        let lpController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThingsController") as! ThingsController
        let goods = GoodsHomeController()
        goods.segmentId = sender.tag
        self.view.window!.rootViewController!.presentViewController(goods, animated: true, completion: nil)
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
        var cyArray = [String]()
        var sjArray = [String]()
        var shArray = [String]()
        var lpArray = [String]()
        for (_, subJson): (String, JSON) in jsonString {
            let categoryId = subJson["category_ID"].stringValue
            let imageUrl = subJson["thumb_path"].stringValue
            switch categoryId {
            case "1":
                self.tataImage.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: nil)
                
            case "2":
                cyArray.append(imageUrl)
                
            case "3":
                sjArray.append(imageUrl)
                
            case "4":
                shArray.append(imageUrl)
                
            case "5":
                lpArray.append(imageUrl)
                
            default:
                break
            }
        }
        
        for i in 0...2 {
            switch i {
            case 0:
                self.cyImage1.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.sjImage1.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.shImage1.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.lpImage1.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
            case 1:
                self.cyImage2.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.sjImage2.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.shImage2.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.lpImage2.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
            case 2:
                self.cyImage3.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.sjImage3.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.shImage3.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.lpImage3.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
            default:
                break
            }
        }
    }
}