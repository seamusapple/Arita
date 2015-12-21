//
//  ThingsController.swift
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

class ThingsController: UIViewController, SMSegmentViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate
{    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 15
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var goodsCollection: UICollectionView!
    @IBOutlet weak var newsCollection: UICollectionView!
    
    var rc = UIRefreshControl()
    
    var collectionTag = 0
    
    let goodsArray: [String] = ["g1","g2","g3","g4","g5","g6","g7","g8","g9","g10","g11","g12"]
    let goodsCategoryArray: [String] = ["趣玩","数码","文具","日用","母婴","箱包","电器","厨房","家居","女装","男装","配饰"]
    let channelId: [String] = ["20","21","22","23","24","25","26","27","28","29","30","31"]
    var goodArray: [JSON] = []
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        /*
        Init SMsegmentView
        Use a Dictionary here to set its properties.
        Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(
            frame: CGRect(x: self.margin, y: 55, width: self.view.frame.size.width - self.margin * 2, height: 30),
            separatorColour: UIColor(white: 0.95, alpha: 0.3),
            separatorWidth: 0.5,
            segmentProperties: [
                keySegmentTitleFont: UIFont.systemFontOfSize(12.0),
                keySegmentOnSelectionColour: UIColor.clearColor(),
                keySegmentOffSelectionColour: UIColor.clearColor(),
                keyContentVerticalMargin: 0.0])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 0
//        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 0.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("", onSelectionImage: UIImage(named: "lpOnSelectL"), offSelectionImage: UIImage(named: "lpOffSelectL"))
        self.segmentView.addSegmentWithTitle("", onSelectionImage: UIImage(named: "lpOnSelectR"), offSelectionImage: UIImage(named: "lpOffSelectR"))
        
        // Set segment with index 0 as selected by default
        segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
        
        self.goodsCollection.dataSource = self
        self.goodsCollection.delegate = self
        self.newsCollection.dataSource = self
        self.newsCollection.delegate = self
        
        self.newsCollection.addSubview(self.rc)
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
            .responseJSON { _, _, aJson in
                self.getGoods(aJson.value)
            }
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if collectionView.isEqual(self.goodsCollection) {
            return 4
        }
        else {
            return (self.goodArray.count + 1) / 2
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.isEqual(self.goodsCollection) {
            return 3
        }
        else {
            if (section + 1) < ((self.goodArray.count + 1) / 2) {
                return 2
            }else {
                if self.goodArray.count % 2 == 0 {
                    return 2
                }else {
                    return 1
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView.isEqual(self.goodsCollection) {
            let cellId = "goodsCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! GoodsCollectionCell
            let name = self.goodsArray[indexPath.section * 3 + indexPath.row]
            let category = self.goodsCategoryArray[indexPath.section * 3 + indexPath.row]
            cell.goodsIcon.image = UIImage(named: name)
            cell.goodsCategory.text = category
            return cell
        }
        else {
            let cellId = "subGoodsCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SubGoodsCollectionCell
            cell.goodsName.text = self.goodArray[indexPath.section * 2 + indexPath.row]["title"].string
            cell.goodsPrice.text = "¥ " + self.goodArray[indexPath.section * 2 + indexPath.row]["price"].string!
            let imageUrl = self.goodArray[indexPath.section * 2 + indexPath.row]["thumb_path"].string
            cell.goodsImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            return cell
        }
        
    }
    
    //MARK: - SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {

        self.collectionTag = segmentIndex
        if segmentIndex == 0 {
            self.goodsCollection.hidden = true
            self.newsCollection.hidden = false
            self.newsCollection.reloadData()
        } else {
            self.goodsCollection.hidden = false
            self.newsCollection.hidden = true
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
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                .responseJSON { _, _, aJson in
                    self.getGoods(aJson.value)
            }
            
            self.rc.endRefreshing()
            self.newsCollection.reloadData()
        }
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
    
    @IBAction func backToHome() {
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    // segue 跳转传参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toSubGoods" {
            let selectedCell: GoodsCollectionCell = sender as! GoodsCollectionCell
            let indexPath = self.goodsCollection.indexPathForCell(selectedCell)
            
            let selectedGoods = self.goodsCategoryArray[indexPath!.section * 3 + indexPath!.row]
            let selectedChannel = self.channelId[indexPath!.section * 3 + indexPath!.row]
            
            let destinationController = segue.destinationViewController as! SubGoodsController
            destinationController.goodsCategory = selectedGoods
            destinationController.channelId = selectedChannel
        } else {
            let selectedCell: SubGoodsCollectionCell = sender as! SubGoodsCollectionCell
            let indexPath: NSIndexPath = self.newsCollection.indexPathForCell(selectedCell)!
            
            let destinationController = segue.destinationViewController as! GoodsWebViewController
            destinationController.goodJson = self.goodArray[indexPath.section * 2 + indexPath.row]
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
        
        self.newsCollection.reloadData()
    }
}