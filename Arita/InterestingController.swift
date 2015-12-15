//
//  InterestingController.swift
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


class InterestingController: UIViewController, SMSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate
{
    var segueId : String = ""
    let segmentTitle: [String:[String]] = [
        "cySegue": ["创意", "摄影", "趣味", "手工", "艺术", "插画"],
        "sjSegue": ["设计", "建筑", "汽车", "家居", "科技", "时尚"],
        "shSegue": ["生活", "盘点", "旅行", "美食", "异国", "萌物"]]
    let channelId: [String:[String]] = [
        "cySegue": ["1", "2", "3", "4", "5", "6"],
        "sjSegue": ["13", "14", "15", "16", "17", "18"],
        "shSegue": ["7", "8", "9", "10", "11", "12"]]
    let onSelected: [String:[String]] = [
        "cySegue": ["1", "2", "3", "4", "5", "6"],
        "sjSegue": ["13", "14", "15", "16", "17", "18"],
        "shSegue": ["7", "8", "9", "10", "11", "12"]]
    let offSelected: [String:[String]] = [
        "cySegue": ["1_", "2_", "3_", "4_", "5_", "6_"],
        "sjSegue": ["13_", "14_", "15_", "16_", "17_", "18_"],
        "shSegue": ["7_", "8_", "9_", "10_", "11_", "12_"]]
    var articleArray: [JSON] = []
    
    @IBOutlet weak var titleOfInteresting: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var interestingTable: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    
    var rc = UIRefreshControl()
    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 0
    var segmentId = 0
    
    var articleNum = 0
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        // Set UITableView delegate
        self.interestingTable.delegate = self
        self.interestingTable.dataSource = self
        
        self.interestingTable.addSubview(self.rc)
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        
        /*
        Init SMsegmentView
        Use a Dictionary here to set its properties.
        Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(
            frame: CGRect(x: self.margin, y: 34, width: self.view.frame.size.width - self.margin * 2, height: 40),
            separatorColour: UIColor.clearColor(),
            separatorWidth: 0,
            segmentProperties: [
                keySegmentTitleFont: UIFont.systemFontOfSize(13.0),
                keySegmentOnSelectionColour: UIColor.whiteColor(),
                keySegmentOffSelectionColour: UIColor.whiteColor(),
                keyContentVerticalMargin: 10.0])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 0
        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 1.0
        self.segmentView.backgroundColor = UIColor.whiteColor()
        
        // Add segments
        for var i = 0; i < self.onSelected[self.segueId]?.count; ++i {
            let onSelectedImage = self.onSelected[self.segueId]![i]
            let offSelectedImage = self.offSelected[self.segueId]![i]
            self.segmentView.addSegmentWithTitle("", onSelectionImage: UIImage(named: onSelectedImage), offSelectionImage: UIImage(named: offSelectedImage))
        }
        
        // Set segment with index 0 as selected by default
        segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
        
        // 判断由哪个入口而来
        switch self.segueId {
        case "cySegue":
            self.titleOfInteresting.text = "创意"
            self.titleImage.image = UIImage(named: "cyTitle")!
            
        case "sjSegue":
            self.titleOfInteresting.text = "设计"
            self.titleImage.image = UIImage(named: "sjTitle")!
            
        case "shSegue":
            self.titleOfInteresting.text = "生活"
            self.titleImage.image = UIImage(named: "shTitle")!
            
        default:
            break
        }
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.articleArray.count < self.articleNum {
            return self.articleArray.count + 1
        } else {
            return self.articleArray.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != self.articleArray.count {
            return 270
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != self.articleArray.count {
            let cellId = "interestingCell"
            let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! InterestingCell
            cell.titleLabel.text = self.articleArray[indexPath.row]["title"].string
            
            switch self.segueId {
            case "cySegue":
                cell.thumbnailImage.backgroundColor = UIColor(red: 240 / 255.0, green: 182 / 255.0, blue: 31 / 255.0, alpha: 1.0)
                
            case "sjSegue":
                cell.thumbnailImage.backgroundColor = UIColor(red: 152 / 255.0, green: 199 / 255.0, blue: 63 / 255.0, alpha: 1.0)
                
            case "shSegue":
                cell.thumbnailImage.backgroundColor = UIColor(red: 233 / 255.0, green: 37 / 255.0, blue: 39 / 255.0, alpha: 1.0)
                
            default:
                break
            }
            let imageUrl = self.articleArray[indexPath.row]["thumb_path"].string
            cell.thumbnailImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            return cell
        } else {
            let cell = LoadMoreCell()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == self.articleArray.count)
        {
            let channelIdSelected = self.channelId[self.segueId]![self.segmentId]
            let id = self.articleArray[self.articleArray.count - 1]["ID"]
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=\(id)&articlesNum=10")
                .responseJSON { aRequest, aResponse, aJson in
                    self.getMoreArticles(aJson.value)
            }
        }
    }
    
    //MARK: - SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        /*
        Replace the following line to implement what you want the app to do after the segment gets tapped.
        */
        let channelIdSelected = self.channelId[self.segueId]![segmentIndex]
        self.segmentId = segmentIndex
        self.titleOfInteresting.text = self.segmentTitle[self.segueId]![segmentIndex]
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
            .responseJSON { _, _, aJson in
                self.getArticle(aJson.value)
            }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        /*
         Replace the following line to your own frame setting for segmentView.
        */
        if toInterfaceOrientation == UIInterfaceOrientation.LandscapeLeft || toInterfaceOrientation == UIInterfaceOrientation.LandscapeRight {
            self.segmentView.organiseMode = .SegmentOrganiseVertical
            self.segmentView.segmentVerticalMargin = 25.0
            self.segmentView.frame = CGRect(x: self.view.frame.size.width/2 - 40.0, y: 100.0, width: 80.0, height: 220.0)
        }
        else {
            self.segmentView.organiseMode = .SegmentOrganiseHorizontal
            self.segmentView.segmentVerticalMargin = 10.0
            self.segmentView.frame = CGRect(x: self.margin, y: 120.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
        }
    }
    
    //MARK: - event response
    func refreshTableView() {
        if (self.rc.refreshing) {
            let channelIdSelected = self.channelId[self.segueId]![self.segmentId]
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_articles_num?channel_ID=\(channelIdSelected)&id=0&articlesNum=10")
                .responseJSON { _, _, aJson in
                    self.getArticle(aJson.value)
            }
            
            self.rc.endRefreshing()
            self.interestingTable.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedCell: InterestingCell = sender as! InterestingCell
        let indexPath: NSIndexPath = self.interestingTable.indexPathForCell(selectedCell)!
        
        let destinationController = segue.destinationViewController as! ContentWebViewController
        destinationController.articleJson = self.articleArray[indexPath.row]
        destinationController.segueId = self.segueId
        destinationController.viewTitle = self.titleOfInteresting.text!
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
    
    func getArticle(data: AnyObject?) {
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
        
        self.interestingTable.reloadData()
        self.interestingTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func getMoreArticles(data: AnyObject?) {
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
        
        self.interestingTable.reloadData()
    }
}