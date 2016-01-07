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
//    , UITableViewDataSource, UITableViewDelegate
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
    var rc = UIRefreshControl()
    
    private var menuColor: UIColor!
    
    private let segmentTitle: [String:[String]] = [
        "cySegue": ["创意", "摄影", "趣味", "手工", "艺术", "插画"],
        "sjSegue": ["设计", "建筑", "汽车", "家居", "科技", "时尚"],
        "shSegue": ["生活", "盘点", "旅行", "美食", "异国", "萌物"]]
    private let channelId: [String:[String]] = [
        "cySegue": ["1", "2", "3", "4", "5", "6"],
        "sjSegue": ["13", "14", "15", "16", "17", "18"],
        "shSegue": ["7", "8", "9", "10", "11", "12"]]
    
    private var segmentId = 0
    
    private var articleArray: [JSON] = []

    private var articleNum = 0
    
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
        self.view.backgroundColor = COLOR_BACKGROUND
        
        // set title field
        switch self.segueId {
        case "cySegue":
            self.titleLabel.text = "创意"
            self.titleViewBg.image = UIImage(named: "cyTitle")!
            self.menuColor = COLOR_CY
            
        case "sjSegue":
            self.titleLabel.text = "设计"
            self.titleViewBg.image = UIImage(named: "sjTitle")!
            self.menuColor = COLOR_SJ
            
        case "shSegue":
            self.titleLabel.text = "生活"
            self.titleViewBg.image = UIImage(named: "shTitle")!
            self.menuColor = COLOR_SH
            
        default:
            break
        }
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "upUser"), forState: UIControlState.Normal)
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        // Tying up the segmented control to a scroll view
        self.segmentedControl.sectionTitles = self.segmentTitle[self.segueId]
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: COLOR_ARTICLE_MENU_TEXT_UNSELECTED_COLOR, NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: self.menuColor, NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectionIndicatorColor = self.menuColor
        self.segmentedControl.selectionIndicatorHeight = 2.0
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown

        let height = SCREEN_HEIGHT - 75
        
        self.segmentedControl.indexChangeBlock = { [weak self] (index: NSInteger) -> Void in
            let x = SCREEN_WIDTH * CGFloat(index)
            self!.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: true)
            
//            let channelIdSelected = self.channelId[self.segueId]![index]
            self!.segmentId = index
            self!.titleLabel.text = self!.segmentTitle[self!.segueId]![index]
//            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
//                .responseJSON { _, _, aJson in
//                    self.getArticle(aJson.value)
//            }
        }

        self.scrollView.backgroundColor = UIColor.grayColor()
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 6, height)
        self.scrollView.scrollRectToVisible(CGRectMake(0, 0, SCREEN_WIDTH, height), animated: false)
        
        self.view1.backgroundColor = COLOR_CY
        self.view2.backgroundColor = COLOR_SJ
        self.view3.backgroundColor = COLOR_SH
        
//        self.table1.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.scrollView.delegate = self
        
//        self.table1.delegate = self
//        self.table1.dataSource = self
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
        
        self.titleLabel.text = self.segmentTitle[self.segueId]![Int(page)]
        self.segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
    }
    
    // MARK: - UITableViewDataSource
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.articleArray.count < self.articleNum {
//            return self.articleArray.count + 1
//        } else {
//            return self.articleArray.count
//        }
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if indexPath.row != self.articleArray.count {
//            let cellId = "interestingCell"
//            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! InterestingCell
//            cell.titleLabel.text = self.articleArray[indexPath.row]["title"].string
//            
//            switch self.segueId {
//            case "cySegue":
//                cell.thumbnailImage.backgroundColor = COLOR_CY
//                
//            case "sjSegue":
//                cell.thumbnailImage.backgroundColor = UIColor(red: 152 / 255.0, green: 199 / 255.0, blue: 63 / 255.0, alpha: 1.0)
//                
//            case "shSegue":
//                cell.thumbnailImage.backgroundColor = UIColor(red: 233 / 255.0, green: 37 / 255.0, blue: 39 / 255.0, alpha: 1.0)
//                
//            default:
//                break
//            }
//            let imageUrl = self.articleArray[indexPath.row]["thumb_path"].string
//            cell.thumbnailImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
//            
//            return cell
//        } else {
//            let cell = LoadMoreCell()
//            return cell
//        }
//    }
    
    // MARK: - UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row != self.articleArray.count {
//            return CELL_HEIGHT
//        } else {
//            return 44
//        }
//    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (indexPath.row == self.articleArray.count)
//        {
//            let channelIdSelected = self.channelId[self.segueId]![self.segmentId]
//            let id = self.articleArray[self.articleArray.count - 1]["ID"]
//            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=\(id)&articlesNum=10")
//                .responseJSON { aRequest, aResponse, aJson in
//                    self.getMoreArticles(aJson.value)
//            }
//        }
//    }
    
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
