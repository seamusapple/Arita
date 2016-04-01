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
    var cyCMSView1 = CMSCoinView()
//    var cyImage1 = UIImageView()
    var cyCMSView2 = CMSCoinView()
//    var cyImage2 = UIImageView()
    var cyCMSView3 = CMSCoinView()
//    var cyImage3 = UIImageView()
    var cyLabel = UIImageView()
    var cyBtn1 = UIButton()
    var cyBtn2 = UIButton()
    var cyBtn3 = UIButton()
    
    var sjView = UIView()
    var sjCMSView1 = CMSCoinView()
//    var sjImage1 = UIImageView()
    var sjCMSView2 = CMSCoinView()
//    var sjImage2 = UIImageView()
    var sjCMSView3 = CMSCoinView()
//    var sjImage3 = UIImageView()
    var sjLabel = UIImageView()
    var sjBtn1 = UIButton()
    var sjBtn2 = UIButton()
    var sjBtn3 = UIButton()
    
    var shView = UIView()
    var shCMSView1 = CMSCoinView()
//    var shImage1 = UIImageView()
    var shCMSView2 = CMSCoinView()
//    var shImage2 = UIImageView()
    var shCMSView3 = CMSCoinView()
//    var shImage3 = UIImageView()
    var shLabel = UIImageView()
    var shBtn1 = UIButton()
    var shBtn2 = UIButton()
    var shBtn3 = UIButton()
    
    var lpView = UIView()
    var lpCMSView1 = CMSCoinView()
//    var lpImage1 = UIImageView()
    var lpCMSView2 = CMSCoinView()
//    var lpImage2 = UIImageView()
    var lpCMSView3 = CMSCoinView()
//    var lpImage3 = UIImageView()
    var lpLabel = UIImageView()
    var lpBtn1 = UIButton()
    var lpBtn2 = UIButton()
    var lpBtn3 = UIButton()
    
    private let width = SCREEN_WIDTH - 20
    private let height = (SCREEN_WIDTH - 20) * 2 / 3
    
    private var timer: NSTimer?
    
    private var flipDic = [Int: [CMSCoinView]]()
    
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
    
    override func viewWillAppear(animated: Bool) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(HomeViewController.flipTimer), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.timer!.invalidate()
        self.timer = nil
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.hideLoginBtn), name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.showLoginBtn), name: "UserLogout", object: nil)
        
        let cyFlipArray = [cyCMSView1, cyCMSView2, cyCMSView3]
        flipDic[0] = cyFlipArray
        
        let sjFlipArray = [sjCMSView1, sjCMSView2, sjCMSView3]
        flipDic[1] = sjFlipArray
        
        let shFlipArray = [shCMSView1, shCMSView2, shCMSView3]
        flipDic[2] = shFlipArray
        
        let lpFlipArray = [lpCMSView1, lpCMSView2, lpCMSView3]
        flipDic[3] = lpFlipArray
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
        self.cyView.addSubview(self.cyCMSView1)
//        self.cyCMSView1.addSubview(self.cyImage1)
        self.cyView.addSubview(self.cyCMSView2)
//        self.cyView.addSubview(self.cyImage2)
        self.cyView.addSubview(self.cyCMSView3)
//        self.cyView.addSubview(self.cyImage3)
        self.cyView.addSubview(self.cyLabel)
        self.cyView.addSubview(self.cyBtn1)
        self.cyView.addSubview(self.cyBtn2)
        self.cyView.addSubview(self.cyBtn3)
        
        self.contentView.addSubview(self.sjView)
        self.sjView.addSubview(self.sjCMSView1)
//        self.sjView.addSubview(self.sjImage1)
        self.sjView.addSubview(self.sjCMSView2)
//        self.sjView.addSubview(self.sjImage2)
        self.sjView.addSubview(self.sjCMSView3)
//        self.sjView.addSubview(self.sjImage3)
        self.sjView.addSubview(self.sjLabel)
        self.sjView.addSubview(self.sjBtn1)
        self.sjView.addSubview(self.sjBtn2)
        self.sjView.addSubview(self.sjBtn3)
        
        self.contentView.addSubview(self.shView)
        self.shView.addSubview(self.shCMSView1)
//        self.shView.addSubview(self.shImage1)
        self.shView.addSubview(self.shCMSView2)
//        self.shView.addSubview(self.shImage2)
        self.shView.addSubview(self.shCMSView3)
//        self.shView.addSubview(self.shImage3)
        self.shView.addSubview(self.shLabel)
        self.shView.addSubview(self.shBtn1)
        self.shView.addSubview(self.shBtn2)
        self.shView.addSubview(self.shBtn3)
        
        self.contentView.addSubview(self.lpView)
        self.lpView.addSubview(self.lpCMSView1)
//        self.lpView.addSubview(self.lpImage1)
        self.lpView.addSubview(self.lpCMSView2)
//        self.lpView.addSubview(self.lpImage2)
        self.lpView.addSubview(self.lpCMSView3)
//        self.lpView.addSubview(self.lpImage3)
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
            make.top.equalTo(self.tataView.snp_bottom).offset(5)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.cyCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cyView)
            make.right.equalTo(self.cyCMSView3.snp_left).offset(-5)
            make.height.equalTo(self.cyCMSView1.snp_width)
        }
        
//        self.cyImage1.snp_makeConstraints { (make) -> Void in
//            make.top.left.equalTo(self.cyView)
//            make.right.equalTo(self.cyImage3.snp_left).offset(-5)
//            make.height.equalTo(self.cyCMSView1.snp_width)
//        }
        
        self.cyCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(self.cyView)
            make.top.equalTo(self.cyCMSView1.snp_bottom).offset(5)
            make.right.equalTo(self.cyCMSView1)
        }
        
//        self.cyImage2.snp_makeConstraints { (make) -> Void in
//            make.left.bottom.equalTo(self.cyView)
//            make.top.equalTo(self.cyCMSView1.snp_bottom).offset(5)
//            make.right.equalTo(self.cyCMSView1)
//        }

        self.cyCMSView3.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(self.cyView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
//        self.cyImage3.snp_makeConstraints { (make) -> Void in
//            make.top.right.equalTo(self.cyView)
//            make.size.equalTo(CGSizeMake(self.height, self.height))
//        }
        
        self.cyLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.cyView)
            make.right.equalTo(self.cyView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.cyBtn1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.cyCMSView1)
        }
        
        self.cyBtn2.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.cyCMSView2)
        }
        
        self.cyBtn3.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.cyCMSView3)
        }
        
        self.sjView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.cyView.snp_bottom).offset(5)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.sjCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.sjView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
//        self.sjImage1.snp_makeConstraints { (make) -> Void in
//            make.top.left.equalTo(self.sjView)
//            make.size.equalTo(CGSizeMake(self.height, self.height))
//        }
        
        self.sjCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.sjCMSView1.snp_right).offset(5)
            make.top.right.equalTo(self.sjView)
            make.height.equalTo(self.sjCMSView2.snp_width)
        }
        
//        self.sjImage2.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(self.sjImage1.snp_right).offset(5)
//            make.top.right.equalTo(self.sjView)
//            make.height.equalTo(self.sjImage2.snp_width)
//        }
        
        self.sjCMSView3.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self.sjView)
            make.top.equalTo(self.sjCMSView2.snp_bottom).offset(5)
            make.left.equalTo(self.sjCMSView2)
        }
        
//        self.sjImage3.snp_makeConstraints { (make) -> Void in
//            make.right.bottom.equalTo(self.sjView)
//            make.top.equalTo(self.sjImage2.snp_bottom).offset(5)
//            make.left.equalTo(self.sjImage2)
//        }
        
        self.sjLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.sjView)
            make.left.equalTo(self.sjView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.sjBtn1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.sjCMSView1)
        }
        
        self.sjBtn2.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.sjCMSView2)
        }
        
        self.sjBtn3.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.sjCMSView3)
        }
        
        self.shView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.sjView.snp_bottom).offset(5)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
        }
        
        self.shCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.shView)
            make.right.equalTo(self.shCMSView3.snp_left).offset(-5)
            make.height.equalTo(self.shCMSView1.snp_width)
        }
        
//        self.shImage1.snp_makeConstraints { (make) -> Void in
//            make.top.left.equalTo(self.shView)
//            make.right.equalTo(self.shImage3.snp_left).offset(-5)
//            make.height.equalTo(self.shImage1.snp_width)
//        }
        
        self.shCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(self.shView)
            make.top.equalTo(self.shCMSView1.snp_bottom).offset(5)
            make.right.equalTo(self.shCMSView1)
        }
        
//        self.shImage2.snp_makeConstraints { (make) -> Void in
//            make.left.bottom.equalTo(self.shView)
//            make.top.equalTo(self.shImage1.snp_bottom).offset(5)
//            make.right.equalTo(self.shImage1)
//        }
        
        self.shCMSView3.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(self.shView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
//        self.shImage3.snp_makeConstraints { (make) -> Void in
//            make.top.right.equalTo(self.shView)
//            make.size.equalTo(CGSizeMake(self.height, self.height))
//        }
        
        self.shLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.shView)
            make.right.equalTo(self.shView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.shBtn1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.shCMSView1)
        }
        
        self.shBtn2.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.shCMSView2)
        }
        
        self.shBtn3.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.shCMSView3)
        }
        
        self.lpView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.shView.snp_bottom).offset(5)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(self.height)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.lpCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.lpView)
            make.size.equalTo(CGSizeMake(self.height, self.height))
        }
        
//        self.lpImage1.snp_makeConstraints { (make) -> Void in
//            make.top.left.equalTo(self.lpView)
//            make.size.equalTo(CGSizeMake(self.height, self.height))
//        }

        self.lpCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.lpCMSView1.snp_right).offset(5)
            make.top.right.equalTo(self.lpView)
            make.height.equalTo(self.lpCMSView2.snp_width)
        }
        
//        self.lpImage2.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(self.lpImage1.snp_right).offset(5)
//            make.top.right.equalTo(self.lpView)
//            make.height.equalTo(self.lpImage2.snp_width)
//        }

        self.lpCMSView3.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self.lpView)
            make.top.equalTo(self.lpCMSView2.snp_bottom).offset(5)
            make.left.equalTo(self.lpCMSView2)
        }
        
//        self.lpImage3.snp_makeConstraints { (make) -> Void in
//            make.right.bottom.equalTo(self.lpView)
//            make.top.equalTo(self.lpImage2.snp_bottom).offset(5)
//            make.left.equalTo(self.lpImage2)
//        }
        
        self.lpLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.lpView)
            make.left.equalTo(self.lpView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
        
        self.lpBtn1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpCMSView1)
        }
        
        self.lpBtn2.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpCMSView2)
        }
        
        self.lpBtn3.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(self.lpCMSView3)
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
        self.loginBtn.addTarget(self, action: #selector(HomeViewController.userLogin), forControlEvents: UIControlEvents.TouchUpInside)
        self.tataBtn.addTarget(self, action: #selector(HomeViewController.goTata), forControlEvents: UIControlEvents.TouchUpInside)
        self.cyBtn1.addTarget(self, action: #selector(HomeViewController.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.cyBtn2.addTarget(self, action: #selector(HomeViewController.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.cyBtn3.addTarget(self, action: #selector(HomeViewController.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.sjBtn1.addTarget(self, action: #selector(HomeViewController.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.sjBtn2.addTarget(self, action: #selector(HomeViewController.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.sjBtn3.addTarget(self, action: #selector(HomeViewController.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.shBtn1.addTarget(self, action: #selector(HomeViewController.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.shBtn2.addTarget(self, action: #selector(HomeViewController.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.shBtn3.addTarget(self, action: #selector(HomeViewController.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn1.addTarget(self, action: #selector(HomeViewController.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn2.addTarget(self, action: #selector(HomeViewController.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.lpBtn3.addTarget(self, action: #selector(HomeViewController.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func goCy(sender: UIButton) {
//        let cy = ArticleViewController()
//        cy.segueId = "cySegue"
//        cy.segmentId = (sender.tag - 1) % 6
//        self.view.window!.rootViewController!.presentViewController(cy, animated: true, completion: nil)
    }
    
    func goSj(sender: UIButton) {
//        let sj = ArticleViewController()
//        sj.segueId = "sjSegue"
//        sj.segmentId = (sender.tag - 1) % 6
//        self.view.window!.rootViewController!.presentViewController(sj, animated: true, completion: nil)
    }
    
    func goSh(sender: UIButton) {
//        let sh = ArticleViewController()
//        sh.segueId = "shSegue"
//        sh.segmentId = (sender.tag - 1) % 6
//        self.view.window!.rootViewController!.presentViewController(sh, animated: true, completion: nil)
    }
    
    func goLp(sender: UIButton) {
//        let goods = GoodsHomeController()
//        goods.segmentId = sender.tag
//        self.view.window!.rootViewController!.presentViewController(goods, animated: true, completion: nil)
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
        
        var cyTitleArray = [String]()
        var sjTitleArray = [String]()
        var shTitleArray = [String]()
        var lpTitleArray = [String]()
        
        var cyIdArray = [Int]()
        var sjIdArray = [Int]()
        var shIdArray = [Int]()
        
        for (_, subJson): (String, JSON) in jsonString {
            let categoryId = subJson["category_ID"].stringValue
            
            let imageUrl = subJson["thumb_path"].stringValue
            let title = subJson["title"].stringValue
            let channelId = subJson["channel_ID"].intValue
            
            switch categoryId {
            case "1":
                self.tataImage.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: nil)
                
            case "2":
                cyArray.append(imageUrl)
                cyTitleArray.append(title)
                cyIdArray.append(channelId)
                
            case "3":
                shArray.append(imageUrl)
                shTitleArray.append(title)
                shIdArray.append(channelId)
                
            case "4":
                sjArray.append(imageUrl)
                sjTitleArray.append(title)
                sjIdArray.append(channelId)
                
            case "5":
                lpArray.append(imageUrl)
                lpTitleArray.append(title)
                
            default:
                break
            }
        }
        
        for i in 0...2 {
            switch i {
            case 0:
//                self.cyImage1.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                let cyImage1 = UIImageView()
                cyImage1.contentMode = UIViewContentMode.ScaleAspectFill
                cyImage1.clipsToBounds = true
                cyImage1.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.cyCMSView1.primaryView = cyImage1
                let cyTitleView1 = UILabel()
                cyTitleView1.text = cyTitleArray[i]
                cyTitleView1.textAlignment = NSTextAlignment.Center
                cyTitleView1.numberOfLines = 3
                cyTitleView1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                cyTitleView1.textColor = UIColor.whiteColor()
                cyTitleView1.backgroundColor = COLOR_TATA
                self.cyCMSView1.secondaryView = cyTitleView1
                self.cyCMSView1.spinTime = 1.0
                
                cyBtn1.tag = cyIdArray[i]
                
//                self.sjImage1.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                let sjImage1 = UIImageView()
                sjImage1.contentMode = UIViewContentMode.ScaleAspectFill
                sjImage1.clipsToBounds = true
                sjImage1.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.sjCMSView1.primaryView = sjImage1
                let sjTitleView1 = UILabel()
                sjTitleView1.text = sjTitleArray[i]
                sjTitleView1.textAlignment = NSTextAlignment.Center
                sjTitleView1.numberOfLines = 3
                sjTitleView1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                sjTitleView1.textColor = UIColor.whiteColor()
                sjTitleView1.backgroundColor = COLOR_TATA
                self.sjCMSView1.secondaryView = sjTitleView1
                self.sjCMSView1.spinTime = 1.0
                
                sjBtn1.tag = sjIdArray[i]
                
//                self.shImage1.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                let shImage1 = UIImageView()
                shImage1.contentMode = UIViewContentMode.ScaleAspectFill
                shImage1.clipsToBounds = true
                shImage1.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.shCMSView1.primaryView = shImage1
                let shTitleView1 = UILabel()
                shTitleView1.text = shTitleArray[i]
                shTitleView1.textAlignment = NSTextAlignment.Center
                shTitleView1.numberOfLines = 3
                shTitleView1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                shTitleView1.textColor = UIColor.whiteColor()
                shTitleView1.backgroundColor = COLOR_TATA
                self.shCMSView1.secondaryView = shTitleView1
                self.shCMSView1.spinTime = 1.0
                
                shBtn1.tag = shIdArray[i]
                
//                self.lpImage1.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                let lpImage1 = UIImageView()
                lpImage1.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                self.lpCMSView1.primaryView = lpImage1
                let lpTitleView1 = UILabel()
                lpTitleView1.text = lpTitleArray[i]
                lpTitleView1.textAlignment = NSTextAlignment.Center
                lpTitleView1.numberOfLines = 3
                lpTitleView1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                lpTitleView1.textColor = UIColor.whiteColor()
                lpTitleView1.backgroundColor = COLOR_TATA
                self.lpCMSView1.secondaryView = lpTitleView1
                self.lpCMSView1.spinTime = 1.0
                
            case 1:
//                self.cyImage2.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                let cyImage2 = UIImageView()
                cyImage2.contentMode = UIViewContentMode.ScaleAspectFill
                cyImage2.clipsToBounds = true
                cyImage2.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.cyCMSView2.primaryView = cyImage2
                let cyTitleView2 = UILabel()
                cyTitleView2.text = cyTitleArray[i]
                cyTitleView2.textAlignment = NSTextAlignment.Center
                cyTitleView2.numberOfLines = 3
                cyTitleView2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                cyTitleView2.textColor = UIColor.whiteColor()
                cyTitleView2.backgroundColor = COLOR_TATA
                self.cyCMSView2.secondaryView = cyTitleView2
                self.cyCMSView2.spinTime = 1.0
                
                cyBtn2.tag = cyIdArray[i]
                
//                self.sjImage2.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                let sjImage2 = UIImageView()
                sjImage2.contentMode = UIViewContentMode.ScaleAspectFill
                sjImage2.clipsToBounds = true
                sjImage2.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.sjCMSView2.primaryView = sjImage2
                let sjTitleView2 = UILabel()
                sjTitleView2.text = sjTitleArray[i]
                sjTitleView2.textAlignment = NSTextAlignment.Center
                sjTitleView2.numberOfLines = 3
                sjTitleView2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                sjTitleView2.textColor = UIColor.whiteColor()
                sjTitleView2.backgroundColor = COLOR_TATA
                self.sjCMSView2.secondaryView = sjTitleView2
                self.sjCMSView2.spinTime = 1.0
                
                sjBtn2.tag = sjIdArray[i]
                
//                self.shImage2.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                let shImage2 = UIImageView()
                shImage2.contentMode = UIViewContentMode.ScaleAspectFill
                shImage2.clipsToBounds = true
                shImage2.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.shCMSView2.primaryView = shImage2
                let shTitleView2 = UILabel()
                shTitleView2.text = shTitleArray[i]
                shTitleView2.textAlignment = NSTextAlignment.Center
                shTitleView2.numberOfLines = 3
                shTitleView2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                shTitleView2.textColor = UIColor.whiteColor()
                shTitleView2.backgroundColor = COLOR_TATA
                self.shCMSView2.secondaryView = shTitleView2
                self.shCMSView2.spinTime = 1.0
                
                shBtn2.tag = shIdArray[i]
                
//                self.lpImage2.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                let lpImage2 = UIImageView()
                lpImage2.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                self.lpCMSView2.primaryView = lpImage2
                let lpTitleView2 = UILabel()
                lpTitleView2.text = lpTitleArray[i]
                lpTitleView2.textAlignment = NSTextAlignment.Center
                lpTitleView2.numberOfLines = 3
                lpTitleView2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                lpTitleView2.textColor = UIColor.whiteColor()
                lpTitleView2.backgroundColor = COLOR_TATA
                self.lpCMSView2.secondaryView = lpTitleView2
                self.lpCMSView2.spinTime = 1.0
                
            case 2:
//                self.cyImage3.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                let cyImage3 = UIImageView()
                cyImage3.contentMode = UIViewContentMode.ScaleAspectFill
                cyImage3.clipsToBounds = true
                cyImage3.kf_setImageWithURL(NSURL(string: cyArray[i])!, placeholderImage: nil)
                self.cyCMSView3.primaryView = cyImage3
                let cyTitleView3 = UILabel()
                cyTitleView3.text = cyTitleArray[i]
                cyTitleView3.textAlignment = NSTextAlignment.Center
                cyTitleView3.numberOfLines = 3
                cyTitleView3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                cyTitleView3.textColor = UIColor.whiteColor()
                cyTitleView3.backgroundColor = COLOR_TATA
                self.cyCMSView3.secondaryView = cyTitleView3
                self.cyCMSView3.spinTime = 1.0
                
                cyBtn3.tag = cyIdArray[i]
                
//                self.sjImage3.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                let sjImage3 = UIImageView()
                sjImage3.contentMode = UIViewContentMode.ScaleAspectFill
                sjImage3.clipsToBounds = true
                sjImage3.kf_setImageWithURL(NSURL(string: sjArray[i])!, placeholderImage: nil)
                self.sjCMSView3.primaryView = sjImage3
                let sjTitleView3 = UILabel()
                sjTitleView3.text = sjTitleArray[i]
                sjTitleView3.textAlignment = NSTextAlignment.Center
                sjTitleView3.numberOfLines = 3
                sjTitleView3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                sjTitleView3.textColor = UIColor.whiteColor()
                sjTitleView3.backgroundColor = COLOR_TATA
                self.sjCMSView3.secondaryView = sjTitleView3
                self.sjCMSView3.spinTime = 1.0
                
                sjBtn3.tag = sjIdArray[i]
                
//                self.shImage3.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                let shImage3 = UIImageView()
                shImage3.contentMode = UIViewContentMode.ScaleAspectFill
                shImage3.clipsToBounds = true
                shImage3.kf_setImageWithURL(NSURL(string: shArray[i])!, placeholderImage: nil)
                self.shCMSView3.primaryView = shImage3
                let shTitleView3 = UILabel()
                shTitleView3.text = shTitleArray[i]
                shTitleView3.textAlignment = NSTextAlignment.Center
                shTitleView3.numberOfLines = 3
                shTitleView3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                shTitleView3.textColor = UIColor.whiteColor()
                shTitleView3.backgroundColor = COLOR_TATA
                self.shCMSView3.secondaryView = shTitleView3
                self.shCMSView3.spinTime = 1.0
                
                shBtn3.tag = shIdArray[i]
                
//                self.lpImage3.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                let lpImage3 = UIImageView()
                lpImage3.kf_setImageWithURL(NSURL(string: lpArray[i])!, placeholderImage: nil)
                self.lpCMSView3.primaryView = lpImage3
                let lpTitleView3 = UILabel()
                lpTitleView3.text = lpTitleArray[i]
                lpTitleView3.textAlignment = NSTextAlignment.Center
                lpTitleView3.numberOfLines = 3
                lpTitleView3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
                lpTitleView3.textColor = UIColor.whiteColor()
                lpTitleView3.backgroundColor = COLOR_TATA
                self.lpCMSView3.secondaryView = lpTitleView3
                self.lpCMSView3.spinTime = 1.0
                
            default:
                break
            }
        }
    }
    
    func flipTimer() {
        let module1 = Int(arc4random() % 4)
        let module2 = Int(arc4random() % 4)
        let random1 = Int(arc4random() % 3)
        let random2 = Int(arc4random() % 3)
        flipDic[module1]![random1].flip()
        flipDic[module2]![random2].flip()
    }
}