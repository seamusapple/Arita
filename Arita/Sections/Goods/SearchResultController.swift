//
//  SearchResultController.swift
//  Arita
//
//  Created by DcBunny on 16/1/13.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchResultController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var keyWord = ""
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    
    var resultTable = UITableView()
    
    private var goodArray: [JSON] = []
    
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
        
        self.view.addSubview(self.resultTable)
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
        
        self.resultTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.bottom.right.equalTo(self.view)
        }

    }
    
    func setPageSubviews() {
        self.view.backgroundColor = COLOR_BACKGROUND
        
        self.titleViewBg.image = UIImage(named: "lpTitle")
        self.titleLabel.text = "搜索\"良品\""
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        
        self.resultTable.backgroundColor = UIColor.clearColor()
        self.resultTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.resultTable.showsVerticalScrollIndicator = false
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.resultTable.dataSource = self
        self.resultTable.delegate = self
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: #selector(SearchResultController.backToUpLevel), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.resultTable.registerClass(SearchGoodCell.self, forCellReuseIdentifier: "SearchGoodCell")
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
        let parameters = ["search_word": self.keyWord]
        
        Alamofire.request(.GET, "http://112.74.192.226/ios/search_goods", parameters: parameters)
            .responseJSON { _, _, aJson in
                self.getGoods(aJson.value)
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "SearchGoodCell"
        let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! SearchGoodCell
        
        let infoString = self.goodArray[indexPath.row]["description"].stringValue
        let attributedString = NSMutableAttributedString(string: infoString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        cell.goodInfo.attributedText = attributedString
        cell.goodInfo.sizeToFit()
        
        let imageUrl = self.goodArray[indexPath.row]["thumb_path"].stringValue
        cell.goodImage.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: nil)
        cell.goodTitle.text = self.goodArray[indexPath.row]["title"].stringValue
        cell.goodPrice.text = "¥ " + self.goodArray[indexPath.row]["price"].stringValue
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let json = self.goodArray[indexPath.row]
        let goodController = GoodController(goodJson: json)
        self.presentViewController(goodController, animated: true, completion: {})
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    //MARK: - private methods
    func getGoods(data: AnyObject?) {
        let jsonString = JSON(data!)
        var tmpDic = [Int: JSON]()
        for (_, subJson): (String, JSON) in jsonString {
            let id = subJson["ID"].intValue
            tmpDic[id] = subJson
        }
        var tmpKeys = [Int]()
        for key in tmpDic.keys {
            tmpKeys.append(key)
        }
        tmpKeys.sortInPlace({$0 > $1})
        self.goodArray.removeAll()
        for id in tmpKeys {
            self.goodArray.append(tmpDic[id]!)
        }
        
        self.resultTable.reloadData()
    }
}