//
//  CategoryController.swift
//  Arita
//
//  Created by DcBunny on 16/1/11.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class CategoryController: UIViewController
{
    var goodsCategory = ""
    var channelId = ""
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var loginBtn = UIButton()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPageSubviews()
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setDatasourceAndDelegate()
        self.setPageEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("CategoryController memory waring.")
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - init methods
    func addPageSubviews() {
        self.view.addSubview(self.titleView)
        self.titleView.addSubview(self.titleViewBg)
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.backBtn)
        self.titleView.addSubview(self.loginBtn)
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
            make.size.equalTo(CGSizeMake(100, 20))
        }
        
        self.backBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.titleView).offset(10)
            make.centerY.equalTo(self.titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        self.loginBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.titleView).offset(-10)
            make.centerY.equalTo(self.titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = COLOR_BACKGROUND
        
        self.titleViewBg.image = UIImage(named: "lpTitle")
        self.titleLabel.text = "良品｜" + self.goodsCategory
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "upUser"), forState: UIControlState.Normal)
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    //MARK: - private methods
}
