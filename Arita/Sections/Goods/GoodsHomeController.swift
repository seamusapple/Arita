//
//  GoodsHomeController.swift
//  Arita
//
//  Created by DcBunny on 16/1/9.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class GoodsHomeController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate
{
    var segmentId: Int!
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var searchBtn = UIButton()
    
    var tagView = UIView()
    var segmentedControl = HMSegmentedControl()
    var scrollView = UIScrollView()
    
    var newGoodsCollection: UICollectionView!
    var categoryCollection: UICollectionView!
    var recommendTable = UITableView()
    
    var newRc = UIRefreshControl()
    var recommendRc = UIRefreshControl()
    
    private let goodsArray: [String] = [
        "g1", "g2", "g3",
        "g4", "g5", "g6",
        "g7", "g8", "g9",
        "g10", "g11", "g12"
    ]
    private let goodsCategoryArray: [String] = [
        "趣玩", "电子", "配饰",
        "美食", "厨房", "母婴",
        "日用", "家居", "文具",
        "女装", "男装", "箱包"
    ]
    private let channelId: [String] = [
        "20", "21", "31",
        "32", "27", "24",
        "23", "28", "22",
        "29", "30", "25"
    ]
    private let categoryArray: [String: String] = [
        "20": "趣玩", "21": "电子", "22": "文具",
        "23": "日用", "24": "母婴", "25": "箱包",
        "27": "厨房", "28": "家居", "29": "女装",
        "30": "男装", "31": "配饰", "32": "美食"
    ]
    private let categoryColorArray: [String: UIColor] = [
        "20": COLOR_QW, "21": COLOR_DZ, "22": COLOR_WJ,
        "23": COLOR_RC, "24": COLOR_MY, "25": COLOR_XB,
        "27": COLOR_CF, "28": COLOR_JJ, "29": COLOR_WZ,
        "30": COLOR_MZ, "31": COLOR_PS, "32": COLOR_MS
    ]
    
    private var goodArray: [JSON] = []
    private var recommendArray: [JSON] = []
    
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
    
    override func viewDidAppear(animated: Bool) {
        let x = SCREEN_WIDTH * CGFloat(self.segmentId)
        self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 75), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("GoodsHomeController memory waring.")
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
        self.titleView.addSubview(self.searchBtn)
        
        self.view.addSubview(self.tagView)
        self.tagView.addSubview(self.segmentedControl)
        self.view.addSubview(self.scrollView)
        
        let newGoodsLayout = UICollectionViewFlowLayout()
        newGoodsLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.newGoodsCollection = UICollectionView(frame: CGRectMake(10, 75, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 75), collectionViewLayout: newGoodsLayout)
        self.scrollView.addSubview(self.newGoodsCollection)
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.categoryCollection = UICollectionView(frame: CGRectMake(0, 75, SCREEN_WIDTH, SCREEN_HEIGHT - 75), collectionViewLayout: categoryLayout)
        self.scrollView.addSubview(self.categoryCollection)
        
        self.scrollView.addSubview(self.recommendTable)
        
        self.newGoodsCollection.addSubview(self.newRc)
        self.recommendTable.addSubview(self.recommendRc)
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
        
        self.searchBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.titleView).offset(-10)
            make.centerY.equalTo(self.titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        self.tagView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        self.segmentedControl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tagView).offset(10)
            make.left.equalTo(self.tagView).offset(10)
            make.right.equalTo(self.tagView).offset(-10)
            make.height.equalTo(30)
        }
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tagView.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.newGoodsCollection.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH - 20)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView).offset(10)
        }
        
        self.categoryCollection.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.newGoodsCollection.snp_right).offset(10)
        }
        
        self.recommendTable.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.categoryCollection.snp_right)
        }
    }
    
    func setPageSubviews() {
        self.view.backgroundColor = COLOR_BACKGROUND
        
        self.titleViewBg.image = UIImage(named: "lpTitle")
        self.titleLabel.text = "良品"
        self.titleLabel.font = FONT_TITLE
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        self.searchBtn.setBackgroundImage(UIImage(named: "search_icon"), forState: UIControlState.Normal)
        
        self.tagView.backgroundColor = UIColor.whiteColor()
        // Tying up the segmented control to a scroll view
        self.segmentedControl.sectionTitles = ["最新", "分类", "推荐"]
        self.segmentedControl.selectedSegmentIndex = self.segmentId
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR, NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: FONT_ARTICLE_MENU_TEXT]
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone
        self.segmentedControl.selectionIndicatorBoxOpacity = 1.0
        self.segmentedControl.verticalDividerEnabled = true
        self.segmentedControl.verticalDividerColor = COLOR_GOODS
        self.segmentedControl.verticalDividerWidth = 1.0
        self.segmentedControl.layer.masksToBounds = true
        self.segmentedControl.layer.cornerRadius = 3
        self.segmentedControl.layer.borderWidth = 1
        self.segmentedControl.layer.borderColor = COLOR_GOODS.CGColor
        
        let height = SCREEN_HEIGHT - 95
        
        self.segmentedControl.indexChangeBlock = { [unowned self] (index: NSInteger) -> Void in
            self.reSetDatasourceAndDelegate(index)
            
            let x = SCREEN_WIDTH * CGFloat(index)
            self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: false)
            
            self.segmentId = index
            if index == 0 && self.goodArray.count == 0 {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                    .responseJSON { _, _, aJson in
                        self.getGoods(aJson.value)
                }
            } else if index == 2 && self.recommendArray.count == 0 {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_recommend_goods")
                    .responseJSON { _, _, aJson in
                        self.getRecommendGoods(aJson.value)
                }
            }
        }
        
        self.scrollView.pagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, height)
        
        self.newGoodsCollection.backgroundColor = UIColor.clearColor()
        self.newGoodsCollection.showsVerticalScrollIndicator = false
        self.newGoodsCollection.tag = 1
        
        self.categoryCollection.backgroundColor = UIColor.whiteColor()
        self.categoryCollection.showsVerticalScrollIndicator = false
        self.categoryCollection.tag = 2
        
        self.recommendTable.backgroundColor = UIColor.clearColor()
        self.recommendTable.showsVerticalScrollIndicator = false
        self.recommendTable.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.scrollView.delegate = self
        
        self.reSetDatasourceAndDelegate(self.segmentId)
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
        self.searchBtn.addTarget(self, action: Selector("searchGoods"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.newGoodsCollection.registerClass(GoodsCell.self, forCellWithReuseIdentifier: "GoodsCell")
        self.categoryCollection.registerClass(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        self.recommendTable.registerClass(RecommendGoodCell.self, forCellReuseIdentifier: "RecommendGoodCell")
        
        self.newRc.addTarget(self, action: "refreshCollectionView", forControlEvents: UIControlEvents.ValueChanged)
        self.recommendRc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
        if self.segmentId == 0 {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                .responseJSON { _, _, aJson in
                    self.getGoods(aJson.value)
            }
        } else if self.segmentId == 2 {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_recommend_goods")
                .responseJSON { _, _, aJson in
                    self.getRecommendGoods(aJson.value)
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageWidth = scrollView.frame.size.width
            let page = scrollView.contentOffset.x / pageWidth
            
            self.segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
            
            self.reSetDatasourceAndDelegate(Int(page))
            if Int(page) == 0 && self.goodArray.count == 0 {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                    .responseJSON { _, _, aJson in
                        self.getGoods(aJson.value)
                }
            } else if Int(page) == 2 && self.recommendArray.count == 0 {
                Alamofire.request(.GET, "http://112.74.192.226/ios/get_recommend_goods")
                    .responseJSON { _, _, aJson in
                        self.getRecommendGoods(aJson.value)
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDatasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1 {
            return (self.goodArray.count + 1) / 2
        } else {
            return 4
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if (section + 1) < ((self.goodArray.count + 1) / 2) {
                return 2
            } else {
                if self.goodArray.count % 2 == 0 {
                    return 2
                } else {
                    return 1
                }
            }
        } else {
            return 3
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cellId = "GoodsCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! GoodsCell
            cell.goodTitle.text = self.goodArray[indexPath.section * 2 + indexPath.row]["title"].string
            cell.goodCategory.text = self.categoryArray[self.goodArray[indexPath.section * 2 + indexPath.row]["channel_ID"].stringValue]!
            cell.goodCategory.textColor = self.categoryColorArray[self.goodArray[indexPath.section * 2 + indexPath.row]["channel_ID"].stringValue]!
            cell.goodPrice.text = "¥ " + self.goodArray[indexPath.section * 2 + indexPath.row]["price"].string!
            let imageUrl = self.goodArray[indexPath.section * 2 + indexPath.row]["thumb_path"].string
            cell.goodImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil)
            
            return cell
        } else {
            let cellId = "CategoryCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CategoryCell
            let name = self.goodsArray[indexPath.section * 3 + indexPath.row]
            let category = self.goodsCategoryArray[indexPath.section * 3 + indexPath.row]
            cell.categoryIcon.image = UIImage(named: name)
            cell.categoryTitle.text = category
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.tag == 1 {
            let goodViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GoodContentView") as! GoodsWebViewController
            goodViewController.goodJson = self.goodArray[indexPath.section * 2 + indexPath.row]
            self.presentViewController(goodViewController, animated: true, completion: {})
        } else {
            let selectedGoods = self.goodsCategoryArray[indexPath.section * 3 + indexPath.row]
            let selectedChannel = self.channelId[indexPath.section * 3 + indexPath.row]
            
            let categoryController = CategoryController()
            categoryController.goodsCategory = selectedGoods
            categoryController.channelId = selectedChannel
            self.presentViewController(categoryController, animated: true, completion: {})
        }
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSizeMake((SCREEN_WIDTH - 30) / 2, (SCREEN_WIDTH - 30) / 2 + 55)
        } else {
            return CGSizeMake((SCREEN_WIDTH - 60) / 3, (SCREEN_WIDTH - 60) / 3)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if collectionView.tag == 1 {
            return UIEdgeInsetsMake(10, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(20, 20, 0, 20)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "RecommendGoodCell"
        let cell = tableView .dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! RecommendGoodCell
        
        let imageUrl = self.recommendArray[indexPath.row]["thumb_path"].stringValue
        cell.goodImage.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: nil)
        cell.goodTitle.text = self.recommendArray[indexPath.row]["title"].stringValue
        cell.goodPrice.text = "¥ " + self.recommendArray[indexPath.row]["price"].stringValue
        cell.dateLabel.text = self.recommendArray[indexPath.row]["publish_time"].stringValue
//        cell.likeNum.text = self.recommendArray[indexPath.row]["favorite_num"].stringValue
        
//        let infoString = self.recommendArray[indexPath.row]["description"].stringValue
//        let attributedString = NSMutableAttributedString(string: infoString)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 5
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
//        cell.goodInfo.attributedText = attributedString
//        cell.goodInfo.sizeToFit()
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return GOOD_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let goodViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GoodContentView") as! GoodsWebViewController
        goodViewController.goodJson = self.recommendArray[indexPath.row]
        self.presentViewController(goodViewController, animated: true, completion: {})
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func searchGoods() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let searchInputController = SearchInputController()
            searchInputController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            searchInputController.providesPresentationContextTransitionStyle = true
            searchInputController.definesPresentationContext = true
            searchInputController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(searchInputController , animated:true, completion: nil)
        })
    }
    
    //MARK: - private methods
    func reSetDatasourceAndDelegate(index: Int) {
        switch index {
        case 0:
            self.newGoodsCollection.dataSource = self
            self.newGoodsCollection.delegate = self
            
            self.categoryCollection.dataSource = nil
            self.categoryCollection.delegate = nil
            
            self.recommendTable.dataSource = nil
            self.recommendTable.delegate = nil
            
        case 1:
            self.newGoodsCollection.dataSource = nil
            self.newGoodsCollection.delegate = nil
            
            self.categoryCollection.dataSource = self
            self.categoryCollection.delegate = self
            
            self.recommendTable.dataSource = nil
            self.recommendTable.delegate = nil
            
        default:
            self.newGoodsCollection.dataSource = nil
            self.newGoodsCollection.delegate = nil
            
            self.categoryCollection.dataSource = nil
            self.categoryCollection.delegate = nil
            
            self.recommendTable.dataSource = self
            self.recommendTable.delegate = self
        }
    }
    
    func refreshCollectionView() {
        if (self.newRc.refreshing) {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                .responseJSON { _, _, aJson in
                    self.getGoods(aJson.value)
            }
            
            self.newRc.endRefreshing()
        }
    }
    
    func refreshTableView() {
        if (self.recommendRc.refreshing) {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_recommend_goods")
                .responseJSON { _, _, aJson in
                    self.getRecommendGoods(aJson.value)
            }
            
            self.recommendRc.endRefreshing()
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

        self.newGoodsCollection.reloadData()
    }
    
    func getRecommendGoods(data: AnyObject?) {
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
        self.recommendArray.removeAll()
        for id in tmpKeys {
            self.recommendArray.append(tmpDic[id]!)
        }
        
        self.recommendTable.reloadData()
    }
}