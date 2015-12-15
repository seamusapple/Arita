//
//  LikeController.swift
//  Arita
//
//  Created by DcBunny on 15/9/8.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class LikeController: UIViewController, SMSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate
{
    var categoryName: [Int: String] = [
        1: "创意", 2: "摄影", 3: "趣味", 4: "手工", 5: "艺术", 6: "插画",
        7: "生活", 8: "盘点", 9: "旅行", 10: "美食", 11: "异国", 12: "萌物",
        13: "设计", 14: "建筑", 15: "汽车", 16: "家园", 17: "科技", 18: "时尚",
        19: "塔塔报"
    ]
    var tataColor = UIColor(red: 255 / 255.0, green: 82 / 255.0, blue: 43 / 255.0, alpha: 1.0)
    var cyColor = UIColor(red: 240 / 255.0, green: 182 / 255.0, blue: 31 / 255.0, alpha: 1.0)
    var sjColor = UIColor(red: 152 / 255.0, green: 199 / 255.0, blue: 63 / 255.0, alpha: 1.0)
    var shColor = UIColor(red: 233 / 255.0, green: 37 / 255.0, blue: 39 / 255.0, alpha: 1.0)
    
    var segueId: [Int: String] = [
        1: "cySegue", 2: "cySegue", 3: "cySegue", 4: "cySegue", 5: "cySegue", 6: "cySegue",
        7: "shSegue", 8: "盘shSegue", 9: "shSegue", 10: "shSegue", 11: "shSegue", 12: "shSegue",
        13: "sjSegue", 14: "sjSegue", 15: "sjSegue", 16: "sjSegue", 17: "sjSegue", 18: "sjSegue",
        19: "Tata"
    ]
    
    var categoryColor: [Int: UIColor] = [Int: UIColor]()
    
    @IBOutlet weak var likeAriticleTable: UITableView!
    @IBOutlet weak var likeGoodsView: UICollectionView!
    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 110.2
    
    var articleArray: [JSON] = []
    var goodArray: [JSON] = []
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryColor = [
            1: cyColor, 2: cyColor, 3: cyColor, 4: cyColor, 5: cyColor, 6: cyColor,
            7: shColor, 8: shColor, 9: shColor, 10: shColor, 11: shColor, 12: shColor,
            13: sjColor, 14: sjColor, 15: sjColor, 16: sjColor, 17: sjColor, 18: sjColor,
            19: tataColor
        ]

        /*
        Init SMsegmentView
        Use a Dictionary here to set its properties.
        Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(
            frame: CGRect(x: self.margin, y: 55, width: self.view.frame.size.width - self.margin * 2, height: 25),
            separatorColour: UIColor(white: 0.95, alpha: 0.3),
            separatorWidth: 0.5,
            segmentProperties: [
                keySegmentTitleFont: UIFont.systemFontOfSize(12.0),
                keySegmentOnSelectionColour: UIColor.redColor(),
                keySegmentOffSelectionColour: UIColor.clearColor(),
                keyContentVerticalMargin: 0.0])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 0
        //        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 0.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("", onSelectionImage: UIImage(named: "collect_articleCurrent"), offSelectionImage: UIImage(named: "collect_article"))
        self.segmentView.addSegmentWithTitle("", onSelectionImage: UIImage(named: "collect_goodsCurrent"), offSelectionImage: UIImage(named: "collect_goods"))
        
        // Set segment with index 0 as selected by default
        segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
        
        self.likeAriticleTable.dataSource = self
        self.likeAriticleTable.delegate = self
        self.likeAriticleTable.backgroundView = nil
        self.likeAriticleTable.backgroundColor = UIColor.clearColor()
        
        self.likeGoodsView.dataSource = self
        self.likeGoodsView.delegate = self
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "likeArticle"
        let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! LikeArticleCell
        cell.articleTitle.text = self.articleArray[indexPath.row]["title"].string
        cell.articleContent.text = self.articleArray[indexPath.row]["description"].string
        let channelId = self.articleArray[indexPath.row]["channel_ID"].intValue
        let category = self.categoryName[channelId]
        if (channelId >= 1 && channelId < 7) {
            cell.categoryLabel.text = "创意｜\(category!)"
        } else if (channelId >= 7 && channelId < 12) {
            cell.categoryLabel.text = "生活｜\(category!)"
        } else if (channelId >= 13 && channelId < 18) {
            cell.categoryLabel.text = "设计｜\(category!)"
        } else {
            cell.categoryLabel.text = "塔塔报｜\(category!)"
        }
        cell.categoryLabel.textColor = self.categoryColor[(self.articleArray[indexPath.row]["channel_ID"].intValue)]
        let imageUrl = self.articleArray[indexPath.row]["thumb_path"].string
        cell.articleImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
        
        return cell
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (self.goodArray.count + 1) / 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellId = "likeGoods"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SubGoodsCollectionCell
        cell.goodsName.text = self.goodArray[indexPath.section * 2 + indexPath.row]["title"].string
        cell.goodsPrice.text = "¥ " + self.goodArray[indexPath.section * 2 + indexPath.row]["price"].string!
        let imageUrl = self.goodArray[indexPath.section * 2 + indexPath.row]["thumb_path"].string
        cell.goodsImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "portrait"))
        
        return cell
    }
    
    //MARK: - SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        
        if segmentIndex == 1 {
            self.likeAriticleTable.hidden = true
            self.likeGoodsView.hidden = false
            
            let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
            if userId != nil {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_like_goods", parameters: ["id": userId!])
                    .responseJSON { _, _, aJson in
                        let jsonString = JSON(aJson.value!)
                        self.goodArray.removeAll()
                        for (_, subJson): (String, JSON) in jsonString {
                            self.goodArray.append(subJson)
                        }
                        
                        self.likeGoodsView.reloadData()
                }
            }
        }
        else {
            self.likeAriticleTable.hidden = false
            self.likeGoodsView.hidden = true
            
            let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
            if userId != nil {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_like_articles", parameters: ["id": userId!])
                    .responseJSON { _, _, aJson in
                        let jsonString = JSON(aJson.value!)
                        self.articleArray.removeAll()
                        for (_, subJson): (String, JSON) in jsonString {
                            self.articleArray.append(subJson)
                        }
                        
                        self.likeAriticleTable.reloadData()
                }
            }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - event response
    @IBAction func backToHome() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "likeArticle" {
            let selectedCell: LikeArticleCell = sender as! LikeArticleCell
            let indexPath: NSIndexPath = self.likeAriticleTable.indexPathForCell(selectedCell)!
            
            let destinationController = segue.destinationViewController as! ContentWebViewController
            destinationController.articleJson = self.articleArray[indexPath.row]
            destinationController.segueId = self.segueId[(self.articleArray[indexPath.row]["channel_ID"].intValue)]!
            destinationController.viewTitle = self.categoryName[(self.articleArray[indexPath.row]["channel_ID"].intValue)]!
        } else {
            let selectedCell: SubGoodsCollectionCell = sender as! SubGoodsCollectionCell
            let indexPath: NSIndexPath = self.likeGoodsView.indexPathForCell(selectedCell)!
            
            let destinationController = segue.destinationViewController as! GoodsWebViewController
            destinationController.goodJson = self.goodArray[indexPath.section * 2 + indexPath.row]
        }
    }
}
