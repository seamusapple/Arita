//
//  goodsController.swift
//  Arita
//
//  Created by DcBunny on 15/8/4.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SubGoodsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var goodsCategory = ""
    var channelId = ""
    var goodArray: [JSON] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subGoodsCollection: UICollectionView!
    @IBOutlet weak var loginBtn: UIButton!
    
    var rc = UIRefreshControl()
    
    var goodsNum = 0
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if isUserLogin() {
            self.loginBtn.hidden = true
        }
        
        self.titleLabel.text = self.titleLabel.text! + self.goodsCategory
        
        self.subGoodsCollection.dataSource = self
        self.subGoodsCollection.delegate = self
        
        self.subGoodsCollection.addSubview(self.rc)
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_goods_num?channel_ID=\(self.channelId)&id=0&goodsNum=100")
            .responseJSON { _, _, aJson in
                self.getGoods(aJson.value)
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
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return ((self.goodArray.count + 1) / 2)
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
        
        let cellId = "subGoodsCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SubGoodsCollectionCell
        cell.goodsName.text = self.goodArray[indexPath.section * 2 + indexPath.row]["title"].string
        cell.goodsPrice.text = "¥ " + self.goodArray[indexPath.section * 2 + indexPath.row]["price"].string!
        let imageUrl = self.goodArray[indexPath.section * 2 + indexPath.row]["thumb_path"].string
        cell.goodsImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
        
        return cell
    }
    
    //MARK: - event response
    func refreshTableView() {
        if (self.rc.refreshing) {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_goods_num?channel_ID=\(self.channelId)&id=0&goodsNum=100")
                .responseJSON { _, _, aJson in
                    self.getGoods(aJson.value)
            }
            
            self.rc.endRefreshing()
            self.subGoodsCollection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedCell: SubGoodsCollectionCell = sender as! SubGoodsCollectionCell
        let indexPath: NSIndexPath = self.subGoodsCollection.indexPathForCell(selectedCell)!
        
        let destinationController = segue.destinationViewController as! GoodsWebViewController
        destinationController.goodJson = self.goodArray[indexPath.section * 2 + indexPath.row]
    }
    
    @IBAction func backToCollection() {
        
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
    
    func getGoods(data: AnyObject?) {
        let jsonString = JSON(data!)
        self.goodsNum = jsonString["goodsNum"].intValue
        self.goodArray.removeAll()
        for (_, subJson): (String, JSON) in jsonString["goodsArrNew"] {
            self.goodArray.append(subJson)
        }
        self.subGoodsCollection.reloadData()
    }
}
