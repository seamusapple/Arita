//
//  HomeViewController.swift
//  Arita
//
//  Created by DcBunny on 15/12/18.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var menuBtn = UIButton()
    var loginBtn = UIButton()
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var btn = UIButton()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initComponents()
        self.addPageSubviews()
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setPageEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("HomeViewController memory waring.")
    }
    
    // MARK: - init methods
    func initComponents() {
    }
    
    func addPageSubviews() {
        self.view.addSubview(self.titleView)
        self.titleView.addSubview(self.titleViewBg)
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.menuBtn)
        self.titleView.addSubview(self.loginBtn)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.btn)
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
            make.size.equalTo(CGSizeMake(UIScreen.mainScreen().bounds.size.width, 800))
            make.edges.equalTo(self.scrollView).inset(0)
        }
        
        self.btn.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView)
            make.size.equalTo(CGSizeMake(50, 50))
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleViewBg.image = UIImage(named: "homeTitle")
        self.titleLabel.text = "阿里塔"
        self.titleLabel.font = UIFont.systemFontOfSize(16)
        self.titleLabel.textColor = UIColor(red: 255 / 255.0, green: 82 / 255.0, blue: 43 / 255.0, alpha: 1.0)
        self.menuBtn.setBackgroundImage(UIImage(named: "menuBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "userBtn"), forState: UIControlState.Normal)
        
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.btn.backgroundColor = UIColor.greenColor()
    }
    
    // MARK: - set events
    func setPageEvents() {
        self.btn.addTarget(self, action: Selector("callTest"), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - event response
    func callTest() {
        let tataController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TataController") as! TataController
        self.view.window!.rootViewController!.presentViewController(tataController, animated: true, completion: nil)
    }
    
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
}