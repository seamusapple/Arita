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

class GoodsHomeController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var segmentId: Int!
    
    var titleView = UIView()
    var titleViewBg = UIImageView()
    var titleLabel = UILabel()
    var backBtn = UIButton()
    var loginBtn = UIButton()
    
    var segmentedControl = HMSegmentedControl()
    var scrollView = UIScrollView()
    
    var newGoodsCollection: UICollectionView!
    var categoryCollection: UICollectionView!
    
    var rc = UIRefreshControl()
    
    private let goodsArray: [String] = ["g1","g2","g3","g4","g5","g6","g7","g8","g9","g10","g11","g12"]
    private let goodsCategoryArray: [String] = ["趣玩","数码","文具","日用","母婴","箱包","电器","厨房","家居","女装","男装","配饰"]
    private let channelId: [String] = ["20","21","22","23","24","25","26","27","28","29","30","31"]
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
    
    override func viewDidAppear(animated: Bool) {
        self.reSetTableDatasourceAndDelegate(self.segmentId)
        
        let x = SCREEN_WIDTH * CGFloat(self.segmentId)
        self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 75), animated: false)
        
        if self.segmentId == 0 {
            self.newGoodsCollection.reloadData()
        }
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
        self.titleView.addSubview(self.loginBtn)
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.scrollView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.newGoodsCollection = UICollectionView(frame: CGRectMake(10, 75, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 75), collectionViewLayout: layout)
        self.scrollView.addSubview(self.newGoodsCollection)
        self.categoryCollection = UICollectionView(frame: CGRectMake(0, 75, SCREEN_WIDTH, SCREEN_HEIGHT - 75), collectionViewLayout: layout)
        self.scrollView.addSubview(self.categoryCollection)
        
        self.newGoodsCollection.addSubview(self.rc)
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
            make.top.equalTo(self.titleView.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(30)
        }
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.segmentedControl.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.newGoodsCollection.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView)
        }
        
        self.categoryCollection.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(self.scrollView.snp_height)
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.newGoodsCollection.snp_right)
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
        self.loginBtn.setBackgroundImage(UIImage(named: "upUser"), forState: UIControlState.Normal)
        
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
        
        let height = SCREEN_HEIGHT - 75
        
        self.segmentedControl.indexChangeBlock = { [weak self] (index: NSInteger) -> Void in
            self!.reSetTableDatasourceAndDelegate(index)
            
            let x = SCREEN_WIDTH * CGFloat(index)
            self!.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: false)
            
            self!.segmentId = index
            if index == 0 {
                self!.newGoodsCollection.reloadData()
            }
        }
        
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, height)
        let x = SCREEN_WIDTH * CGFloat(self.segmentId)
        self.scrollView.scrollRectToVisible(CGRectMake(x, 0, SCREEN_WIDTH, height), animated: false)
        
        self.newGoodsCollection.backgroundColor = UIColor.greenColor()
        self.newGoodsCollection.showsVerticalScrollIndicator = false
        self.newGoodsCollection.tag = 1
        
        self.categoryCollection.backgroundColor = UIColor.clearColor()
        self.categoryCollection.showsVerticalScrollIndicator = false
        self.categoryCollection.tag = 2
    }
    
    // MARK: - set datasource, delegate and events
    func setDatasourceAndDelegate() {
        self.scrollView.delegate = self
    }
    
    func setPageEvents() {
        self.backBtn.addTarget(self, action: Selector("backToUpLevel"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.loginBtn.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.newGoodsCollection.registerClass(GoodsCell.self, forCellWithReuseIdentifier: "GoodsCell")
        self.categoryCollection.registerClass(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        self.rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: - load data from server
    func loadDataFromServer() {
        Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
            .responseJSON { _, _, aJson in
                self.getGoods(aJson.value)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageWidth = scrollView.frame.size.width
            let page = scrollView.contentOffset.x / pageWidth
            
            self.segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
            
            self.reSetTableDatasourceAndDelegate(Int(page))
            if page == 0 {
                self.newGoodsCollection.reloadData()
            }
        }
    }
    
    // MARK: - UICollectionViewDatasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1 {
            print("new good")
            return (self.goodArray.count + 1) / 2
        } else {
            print("category")
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
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSizeMake((SCREEN_WIDTH - 30) / 2, (SCREEN_WIDTH - 30) / 2 + 70)
        } else {
            return CGSizeMake((SCREEN_WIDTH - 20) / 3, (SCREEN_WIDTH - 20) / 3)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if collectionView.tag == 1 {
            return UIEdgeInsetsMake(10, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    // MARK: - UITableViewDataSource
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    }
    
    // MARK: - UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//    }
    
    // MARK: - event response
    func backToUpLevel() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    //MARK: - private methods
    func reSetTableDatasourceAndDelegate(index: Int) {
//        self.rc.removeFromSuperview()
        switch index {
        case 0:
            self.newGoodsCollection.dataSource = self
            self.newGoodsCollection.delegate = self
            
            self.categoryCollection.dataSource = nil
            self.categoryCollection.delegate = nil
        case 1:
            self.newGoodsCollection.dataSource = nil
            self.newGoodsCollection.delegate = nil
            
            self.categoryCollection.dataSource = self
            self.categoryCollection.delegate = self
        default:
            self.newGoodsCollection.dataSource = nil
            self.newGoodsCollection.delegate = nil
            
            self.categoryCollection.dataSource = nil
            self.categoryCollection.delegate = nil
        }
    }
    
    func refreshTableView() {
        if (self.rc.refreshing) {
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_all_goods")
                .responseJSON { _, _, aJson in
                    self.getGoods(aJson.value)
            }
            
            self.rc.endRefreshing()
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

        self.reSetTableDatasourceAndDelegate(0)
        self.newGoodsCollection.reloadData()
    }
}