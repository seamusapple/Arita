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

class ArticleViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate
{
    var segueId: String!
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var loginBtn = UIButton()
    
    var segmentedControl = HMSegmentedControl()
    var scrollView = UIScrollView()
    
    var table1 = UITableView()
    var table2 = UITableView()
    var table3 = UITableView()
    var table4 = UITableView()
    var table5 = UITableView()
    var table6 = UITableView()
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
    
    var segmentId: Int!
    
    private var articleArray: [JSON] = []

    private var articleNum = 0
    
    private var tableArray: [UITableView] = []
    
    private var cellIndex = 0
    
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
        self.scrollView.addSubview(self.table1)
        self.scrollView.addSubview(self.table2)
        self.scrollView.addSubview(self.table3)
        self.scrollView.addSubview(self.table4)
        self.scrollView.addSubview(self.table5)
        self.scrollView.addSubview(self.table6)
        
        self.tableArray.append(self.table1)
        self.tableArray.append(self.table2)
        self.tableArray.append(self.table3)
        self.tableArray.append(self.table4)
        self.tableArray.append(self.table5)
        self.tableArray.append(self.table6)
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
            make.height.equalTo(30)
        }
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.segmentedControl.snp_bottom).offset(10)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.table1.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.left.equalTo(self.scrollView)
        }
        
        self.table2.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.table1.snp_right)
        }
        
        self.table3.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.table2.snp_right)
        }
        
        self.table4.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.table3.snp_right)
        }
        
        self.table5.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.table4.snp_right)
        }
        
        self.table6.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.table5.snp_right)
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = COLOR_BACKGROUND
        
        // set title field
        switch self.segueId {
        case "cySegue":
            self.titleViewBg.image = UIImage(named: "cyTitle")!
            self.menuColor = COLOR_CY
            
        case "sjSegue":
            self.titleViewBg.image = UIImage(named: "sjTitle")!
            self.menuColor = COLOR_SJ
            
        case "shSegue":
            self.titleViewBg.image = UIImage(named: "shTitle")!
            self.menuColor = COLOR_SH
            
        default:
            break
        }
        self.titleLabel.text = self.segmentTitle[self.segueId]![segmentId]
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
        self.segmentedControl.selectedSegmentIndex = segmentId
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: COLOR_ARTICLE_MENU_TEXT_UNSELECTED_COLOR, NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: self.menuColor, NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectionIndicatorColor = self.menuColor
        self.segmentedControl.selectionIndicatorHeight = 2.0
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown

        let height = SCREEN_HEIGHT - 95
        
        self.segmentedControl.indexChangeBlock = { [unowned self] (index: NSInteger) -> Void in
//            self.reSetTableDatasourceAndDelegate(index)
            
            let x = SCREEN_WIDTH * CGFloat(index)
            self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: false)
            
            self.segmentId = index
            self.titleLabel.text = self.segmentTitle[self.segueId]![index]
            
            let channelIdSelected = self.channelId[self.segueId]![index]
//            self.articleArray.removeAll()
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
                .responseJSON { _, _, aJson in
                    self.getArticle(aJson.value, index: index)
            }
        }

        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 6, height)
        self.scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH * CGFloat(segmentId), y: 0), animated: false)
        
        self.table1.backgroundColor = UIColor.clearColor()
        self.table1.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table1.showsVerticalScrollIndicator = false
        self.table1.tag = 1
        
        self.table2.backgroundColor = UIColor.clearColor()
        self.table2.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table2.showsVerticalScrollIndicator = false
        self.table2.tag = 2
        
        self.table3.backgroundColor = UIColor.clearColor()
        self.table3.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table3.showsVerticalScrollIndicator = false
        self.table3.tag = 3
        
        self.table4.backgroundColor = UIColor.clearColor()
        self.table4.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table4.showsVerticalScrollIndicator = false
        self.table4.tag = 4
        
        self.table5.backgroundColor = UIColor.clearColor()
        self.table5.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table5.showsVerticalScrollIndicator = false
        self.table5.tag = 5
        
        self.table6.backgroundColor = UIColor.clearColor()
        self.table6.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table6.showsVerticalScrollIndicator = false
        self.table6.tag = 6
        
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.scrollView.delegate = self
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.table1.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell1")
        self.table2.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell2")
        self.table3.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell3")
        self.table4.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell4")
        self.table5.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell5")
        self.table6.registerClass(ArticleCell.self, forCellReuseIdentifier: "ArticleCell6")
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
//        self.reSetTableDatasourceAndDelegate(0)
        let channelIdSelected = self.channelId[self.segueId]![segmentId]
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
            .responseJSON { _, _, aJson in
                self.getArticle(aJson.value, index: self.segmentId)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageWidth = scrollView.frame.size.width
            let page = scrollView.contentOffset.x / pageWidth
            
            self.titleLabel.text = self.segmentTitle[self.segueId]![Int(page)]
            self.segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
            
//            self.reSetTableDatasourceAndDelegate(Int(page))
            let channelIdSelected = self.channelId[self.segueId]![Int(page)]
//            self.articleArray.removeAll()
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
                .responseJSON { _, _, aJson in
                    self.getArticle(aJson.value, index: Int(page))
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.articleArray.count < self.articleNum {
            return self.articleArray.count + 1
        } else {
            return self.articleArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != self.articleArray.count {
            var cellId = ""
            switch tableView.tag {
            case 1:
                cellId = "ArticleCell1"
            case 2:
                cellId = "ArticleCell2"
            case 3:
                cellId = "ArticleCell3"
            case 4:
                cellId = "ArticleCell4"
            case 5:
                cellId = "ArticleCell5"
            case 6:
                cellId = "ArticleCell6"
            default:
                break
            }
            
            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! ArticleCell
            
            cell.articleTitle.text = self.articleArray[indexPath.row]["title"].string
            cell.articleTitle.textColor = self.menuColor
            
            let imageUrl = self.articleArray[indexPath.row]["thumb_path"].string
            cell.articleImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            let infoString = self.articleArray[indexPath.row]["content"].stringValue
            let attributedString = NSMutableAttributedString(string: infoString)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.articleInfo.attributedText = attributedString
            cell.articleInfo.sizeToFit()
            
            return cell
        } else {
            let cell = LoadMoreCell()
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != self.articleArray.count {
            return CELL_HEIGHT
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == self.articleArray.count) {
            let channelIdSelected = self.channelId[self.segueId]![self.segmentId]
            let id = self.articleArray[self.articleArray.count - 1]["ID"]
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=\(id)&articlesNum=10")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getMoreArticles(aJson.value, index: self.segmentId)
            }
        } else {
            if indexPath.row >= cellIndex {
                cellIndex = indexPath.row
                cell.contentView.frame.origin.y = 100
                UIView.animateWithDuration(0.8, animations: {
                    cell.contentView.frame.origin.y = 0
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ContentView") as! ContentWebViewController
        destinationController.articleJson = self.articleArray[indexPath.row]
        destinationController.segueId = self.segueId
        destinationController.viewTitle = self.titleLabel.text!
        self.presentViewController(destinationController, animated: true, completion: {})
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
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
    
    func refreshTableView() {
        if (self.rc.refreshing) {
            let channelIdSelected = self.channelId[self.segueId]![self.segmentId]
//            self.articleArray.removeAll()
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
                .responseJSON { _, _, aJson in
                    self.getArticle(aJson.value, index: self.segmentId)
            }
            
            self.rc.endRefreshing()
        }
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
    
    func reSetTableDatasourceAndDelegate(index: Int) {
        self.rc.removeFromSuperview()
        for var i = 0; i < self.tableArray.count; ++i {
            if i == index {
                self.tableArray[i].dataSource = self
                self.tableArray[i].delegate = self
                self.tableArray[i].addSubview(self.rc)
            } else {
                self.tableArray[i].dataSource = nil
                self.tableArray[i].delegate = nil
            }
        }
    }
    
    func getArticle(data: AnyObject?, index: Int) {
        let jsonString = JSON(data!)
        self.articleNum = jsonString["articlesNum"].intValue
        var tmpDic = [Int: JSON]()
        for (_, subJson): (String, JSON) in jsonString["articleArrNew"] {
            let id = subJson["ID"].intValue
            tmpDic[id] = subJson
        }
        var tmpKeys = [Int]()
        for key in tmpDic.keys {
            tmpKeys.append(key)
        }
        tmpKeys.sortInPlace({$0 > $1})
        self.articleArray.removeAll()
        for id in tmpKeys {
            self.articleArray.append(tmpDic[id]!)
        }
        self.reSetTableDatasourceAndDelegate(index)
        self.tableArray[index].reloadData()
    }
    
    func getMoreArticles(data: AnyObject?, index: Int) {
        let jsonString = JSON(data!)
        self.articleNum = jsonString["articlesNum"].intValue
        var tmpDic = [Int: JSON]()
        for (_, subJson): (String, JSON) in jsonString["articleArrNew"] {
            let id = subJson["ID"].intValue
            tmpDic[id] = subJson
        }
        var tmpKeys = [Int]()
        for key in tmpDic.keys {
            tmpKeys.append(key)
        }
        tmpKeys.sortInPlace({$0 > $1})
        
        for id in tmpKeys {
            self.articleArray.append(tmpDic[id]!)
        }
        
        self.tableArray[index].reloadData()
    }
}
