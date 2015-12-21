//
//  TataController.swift
//  Arita
//
//  Created by DcBunny on 15/7/22.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class TataController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tataTable: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    
    var rc = UIRefreshControl()
    
    var newsArray:[JSON] = []
    
    var articleNum = 0
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        self.tataTable.delegate = self
        self.tataTable.dataSource = self
        
        self.tataTable.addSubview(self.rc)
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&id=0&articlesNum=10")
            .responseJSON { aRequest, aResponse, aJson in
                self.getNews(aJson.value)
            }
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.newsArray.count < self.articleNum {
            return self.newsArray.count + 1
        } else {
            return self.newsArray.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != self.newsArray.count {
            return 265
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != self.newsArray.count {
            let cellId = "tataNewsCell"
            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TataNewsCell
            cell.titleOfNew.text = self.newsArray[indexPath.row]["title"].string
            let dateOfArticle = self.newsArray[indexPath.row]["publish_time"].string
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.dateFromString(dateOfArticle!)
            let dateFormaterForMY = NSDateFormatter()
            dateFormaterForMY.dateFormat = "dd MMM."
            dateFormaterForMY.locale = NSLocale(localeIdentifier: "en_US")
            cell.dateLabel.text = dateFormaterForMY.stringFromDate(date!)
            let imageUrl = self.newsArray[indexPath.row]["thumb_path"].string
            cell.thumbnailOfNew.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            return cell
        } else {
            let cell = LoadMoreCell()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == self.newsArray.count)
        {
            let id = self.newsArray[self.newsArray.count - 1]["ID"]

            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&id=\(id)&articlesNum=10")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getMoreNews(aJson.value)
            }
        }
    }
    
    //MARK: - event response
    func refreshTableView() {
        if (self.rc.refreshing) {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=19&id=0&articlesNum=10")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getNews(aJson.value)
            }
            
            self.rc.endRefreshing()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedCell: TataNewsCell = sender as! TataNewsCell
        let indexPath: NSIndexPath = self.tataTable.indexPathForCell(selectedCell)!
        
        let destinationController = segue.destinationViewController as! ContentWebViewController
        destinationController.articleJson = self.newsArray[indexPath.row]
        destinationController.segueId = segue.identifier!
        let time = self.newsArray[indexPath.row]["publish_time"].string
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(time!)
        let dateFormatterForDay = NSDateFormatter()
        dateFormatterForDay.dateFormat = "MMdd"
        destinationController.viewTitle = "塔塔报 | " + dateFormatterForDay.stringFromDate(date!)
    }
    
    @IBAction func backToHome() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func userLogin() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartLoginController = ThirdPartLoginController()
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(thirdPartLoginController , animated:true, completion: nil)
        })
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
        self.newsArray.removeAll()
        for id in tmpKeys {
            self.newsArray.append(tmpDic[id]!)
        }
        
        self.tataTable.reloadData()
    }
    
    func getMoreNews(data: AnyObject?) {
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
        
//        var indexPaths = [NSIndexPath]()
        for id in tmpKeys {
//            indexPaths.append(NSIndexPath(forRow: self.newsArray.count, inSection: 0))
            self.newsArray.append(tmpDic[id]!)
        }
        
        self.tataTable.reloadData()
//        self.tataTable.beginUpdates()
//        self.tataTable.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
//        self.tataTable.endUpdates()
    }
}