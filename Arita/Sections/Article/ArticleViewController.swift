//
//  ArticleViewController.swift
//  Arita
//
//  Created by DcBunny on 16/1/4.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleViewController: UIViewController, UIScrollViewDelegate
{
    var segueId: String!
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var loginBtn = UIButton()
    
    var segmentedControl = HMSegmentedControl()
    var scrollView = UIScrollView()
    
    var view1 = UIView()
    var view2 = UIView()
    var view3 = UIView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPageSubviews()
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setDatasourceAndDelegate()
        self.setPageEvents()
        self.loadDataFromServer()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideLoginBtn", name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLoginBtn", name: "UserLogout", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UserLogout", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("ArticleViewController memory waring.")
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
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.view1)
        self.scrollView.addSubview(self.view2)
        self.scrollView.addSubview(self.view3)
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
        
        self.segmentedControl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.segmentedControl.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.view1.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.left.equalTo(self.scrollView)
        }
        
        self.view2.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.view1.snp_right)
        }
        
        self.view3.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.view2.snp_right)
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        // set title field
        switch self.segueId {
        case "cySegue":
            self.titleLabel.text = "创意"
            self.titleViewBg.image = UIImage(named: "cyTitle")!
            
        case "sjSegue":
            self.titleLabel.text = "设计"
            self.titleViewBg.image = UIImage(named: "sjTitle")!
            
        case "shSegue":
            self.titleLabel.text = "生活"
            self.titleViewBg.image = UIImage(named: "shTitle")!
            
        default:
            break
        }
        self.titleLabel.font = UIFont.systemFontOfSize(16)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "upUser"), forState: UIControlState.Normal)
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        // Tying up the segmented control to a scroll view
        self.segmentedControl.sectionTitles = ["我是", "无敌", "胖胖"]
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1)]
        self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 240 / 255.0, green: 182 / 255.0, blue: 31 / 255.0, alpha: 1.0)]
        self.segmentedControl.selectionIndicatorColor = UIColor(red: 240 / 255.0, green: 182 / 255.0, blue: 31 / 255.0, alpha: 1.0)
        self.segmentedControl.selectionIndicatorHeight = 2.0
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown

        let height = self.scrollView.frame.height
        
        self.segmentedControl.indexChangeBlock = {(index: NSInteger) -> Void in
            let x = SCREEN_WIDTH * CGFloat(index)
            self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: true)
        }

        self.scrollView.backgroundColor = UIColor.grayColor()
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, height)
        self.scrollView.scrollRectToVisible(CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, height), animated: false)
        
        self.view1.backgroundColor = UIColor.whiteColor()
        self.view2.backgroundColor = UIColor.whiteColor()
        self.view3.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.scrollView.delegate = self
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = scrollView.contentOffset.x / pageWidth
        
        self.segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    // MARK: - UITableViewDelegate
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func userLogin() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartLoginController = ThirdPartLoginController()
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(thirdPartLoginController, animated: true, completion: {})
        })
    }
    
    func hideLoginBtn() {
        self.loginBtn.hidden = true
    }
    
    func showLoginBtn() {
        self.loginBtn.hidden = false
    }
    
    // MARK: - private methods
    func isUserLogin() -> Bool {
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            return true
        } else {
            return false
        }
    }
}
