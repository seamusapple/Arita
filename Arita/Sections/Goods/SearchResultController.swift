//
//  SearchResultController.swift
//  Arita
//
//  Created by DcBunny on 16/1/13.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class SearchResultController: UIViewController
{
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    
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
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleViewBg.image = UIImage(named: "lpTitle")
        self.titleLabel.text = "搜索\"良品\""
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
//        Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&id=0&articlesNum=10")
//            .responseJSON { aRequest, aResponse, aJson in
//                self.getNews(aJson.value)
//        }
    }
    
    //MARK: - UITableViewDataSource
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.newsArray.count < self.articleNum {
//            return self.newsArray.count + 1
//        } else {
//            return self.newsArray.count
//        }
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if indexPath.row != self.newsArray.count {
//            let cellId = "TataCell"
//            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TataCell
//            cell.tataTitle.text = self.newsArray[indexPath.row]["title"].string
//            let dateOfArticle = self.newsArray[indexPath.row]["publish_time"].string
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let date = dateFormatter.dateFromString(dateOfArticle!)
//            let dateFormaterForMY = NSDateFormatter()
//            dateFormaterForMY.dateFormat = "dd MMM."
//            dateFormaterForMY.locale = NSLocale(localeIdentifier: "en_US")
//            cell.timestamp.text = dateFormaterForMY.stringFromDate(date!)
//            let imageUrl = self.newsArray[indexPath.row]["thumb_path"].string
//            cell.tataImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
//            
//            let infoString = self.newsArray[indexPath.row]["content"].stringValue
//            let attributedString = NSMutableAttributedString(string: infoString)
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = 5
//            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
//            cell.tataInfo.attributedText = attributedString
//            cell.tataInfo.sizeToFit()
//            
//            return cell
//        } else {
//            let cell = LoadMoreCell()
//            return cell
//        }
//    }
    
    // MARK: - UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row != self.newsArray.count {
//            return CELL_HEIGHT
//        } else {
//            return 44
//        }
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ContentView") as! ContentWebViewController
//        destinationController.articleJson = self.newsArray[indexPath.row]
//        destinationController.segueId = "Tata"
//        let time = self.newsArray[indexPath.row]["publish_time"].string
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = dateFormatter.dateFromString(time!)
//        let dateFormatterForDay = NSDateFormatter()
//        dateFormatterForDay.dateFormat = "MMdd"
//        destinationController.viewTitle = "塔塔报 | " + dateFormatterForDay.stringFromDate(date!)
//        self.presentViewController(destinationController, animated: true, completion: {})
//        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    //MARK: - private methods
//    func getNews(data: AnyObject?) {
//        let jsonString = JSON(data!)
//        self.articleNum = jsonString["articlesNum"].intValue
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
//        self.newsArray.removeAll()
//        for id in tmpKeys {
//            self.newsArray.append(tmpDic[id]!)
//        }
//        
//        self.tataTable.reloadData()
//    }
}