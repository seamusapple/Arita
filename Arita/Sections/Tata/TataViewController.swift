//
//  TataViewController.swift
//  Arita
//
//  Created by DcBunny on 16/1/1.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var loginBtn = UIButton()
    
    var tataTable = UITableView()
    var rc = UIRefreshControl()
    
    var newsArray:[JSON] = []
    var articleNum = 0
    
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
        print("TataViewController memory waring.")
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
        
        self.view.addSubview(self.tataTable)
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
        
        self.tataTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.bottom.right.equalTo(self.view)
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleViewBg.image = UIImage(named: "tataTitle")
        self.titleLabel.text = "塔塔报"
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "upUser"), forState: UIControlState.Normal)
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        self.tataTable.backgroundColor = UIColor.clearColor()
        self.tataTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tataTable.showsVerticalScrollIndicator = false
        self.tataTable.addSubview(self.rc)
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.tataTable.delegate = self
        self.tataTable.dataSource = self
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.tataTable.registerClass(TataCell.self, forCellReuseIdentifier: "TataCell")
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&timestamp=0&articlesNum=\(LOAD_ARTICLE_NUM)")
            .responseJSON { aRequest, aResponse, aJson in
                self.getNews(aJson.value)
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.newsArray.count < self.articleNum {
            return self.newsArray.count + 1
        } else {
            return self.newsArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != self.newsArray.count {
            let cellId = "TataCell"
            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TataCell
            
//            let dateOfArticle = self.newsArray[indexPath.row]["publish_time"].string
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let date = dateFormatter.dateFromString(dateOfArticle!)
//            let dateFormaterForMY = NSDateFormatter()
//            dateFormaterForMY.dateFormat = "MMdd"
//            dateFormaterForMY.locale = NSLocale(localeIdentifier: "en_US")
//            let dateString = dateFormaterForMY.stringFromDate(date!)
//            cell.timestamp.text = dateFormaterForMY.stringFromDate(date!)
            
            cell.tataTitle.text = self.newsArray[indexPath.row]["title"].string!
            
            let imageUrl = self.newsArray[indexPath.row]["thumb_path"].string
            cell.tataImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            let infoString = self.newsArray[indexPath.row]["content"].stringValue
            let attributedString = NSMutableAttributedString(string: infoString)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.tataInfo.attributedText = attributedString
            cell.tataInfo.sizeToFit()
            
            return cell
        } else {
            let cell = LoadMoreCell()
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != self.newsArray.count {
            return CELL_HEIGHT
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ContentView") as! ContentWebViewController
        destinationController.articleJson = self.newsArray[indexPath.row]
        destinationController.segueId = "Tata"
        let time = self.newsArray[indexPath.row]["publish_time"].string
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(time!)
        let dateFormatterForDay = NSDateFormatter()
        dateFormatterForDay.dateFormat = "MMdd"
        destinationController.viewTitle = "塔塔报 | " + dateFormatterForDay.stringFromDate(date!)
        self.presentViewController(destinationController, animated: true, completion: {})
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == self.newsArray.count) {
            let timestamp = self.newsArray[self.newsArray.count - 1]["publish_time"].stringValue
            let encodeString = timestamp.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&timestamp=\(encodeString)&articlesNum=\(LOAD_ARTICLE_NUM)")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getMoreNews(aJson.value)
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
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&timestamp=0&articlesNum=\(LOAD_ARTICLE_NUM)")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getNews(aJson.value)
            }
            
            self.rc.endRefreshing()
        }
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
    
    func getNews(data: AnyObject?) {
        let jsonString = JSON(data!)
        self.articleNum = jsonString["articlesNum"].intValue
        
//        var tmpDic = [Int: JSON]()
//        for (_, subJson): (String, JSON) in jsonString["articleArrNew"] {
//            let id = subJson["ID"].intValue
//            tmpDic[id] = subJson
//        }
//        var tmpKeys = [Int]()
//        for key in tmpDic.keys {
//            tmpKeys.append(key)
//        }
//        tmpKeys.sortInPlace({$0 > $1})
        self.newsArray.removeAll()
//        for id in tmpKeys {
//            self.newsArray.append(tmpDic[id]!)
//        }
        
        self.newsArray = jsonString["articleArrNew"].arrayValue
        
        self.tataTable.reloadData()
    }
    
    func getMoreNews(data: AnyObject?) {
        let jsonString = JSON(data!)
        self.articleNum = jsonString["articlesNum"].intValue
        
//        var tmpDic = [Int: JSON]()
//        for (_, subJson): (String, JSON) in jsonString["articleArrNew"] {
//            let id = subJson["ID"].intValue
//            tmpDic[id] = subJson
//        }
//        var tmpKeys = [Int]()
//        for key in tmpDic.keys {
//            tmpKeys.append(key)
//        }
//        tmpKeys.sortInPlace({$0 > $1})
//        
//        for id in tmpKeys {
//            self.newsArray.append(tmpDic[id]!)
//        }
        
        newsArray += jsonString["articleArrNew"].arrayValue
        
        self.tataTable.reloadData()
    }
}
