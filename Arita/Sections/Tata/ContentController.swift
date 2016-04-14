//
//  TataContentController.swift
//  Arita
//
//  Created by DcBunny on 16/4/3.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContentController: UIViewController, UIWebViewDelegate {
    
    // 标题导航栏
    let titleView = UIView()
    let titleLabel = UILabel()
    let backBtn = UIButton()
    
    // 内容WebView
    let contentView = UIWebView()
    
    // 底部操作栏
    let bottomTabBar = UIView()
    
    let likeView = UIView()
    let likeIcon = UIImageView()
    let likeTitle = UILabel()
    let likeBtn = UIButton()
    
    let commentView = UIView()
    let separatorL = UIView()
    let separatorR = UIView()
    let commentIcon = UIImageView()
    let commentTitle = UILabel()
    let commentBtn = UIButton()
    
    let shareView = UIView()
    let shareIcon = UIImageView()
    let shareTitle = UILabel()
    let shareBtn = UIButton()
    
    var contentTitle: String
    var segueId: String
    var articleJson: JSON
    
    private var isLike = false
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPageSubviews()
        layoutPageSubviews()
        setPageSubviews()
        setPageEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("ContentController memory waring.")
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - init methods
    init(contentTitle: String, from segueId: String, with articleJson: JSON) {
        self.contentTitle = contentTitle
        self.segueId = segueId
        self.articleJson = articleJson
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPageSubviews() {
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(backBtn)
        
        view.addSubview(bottomTabBar)
        
        bottomTabBar.addSubview(likeView)
        likeView.addSubview(likeIcon)
        likeView.addSubview(likeTitle)
        likeView.addSubview(likeBtn)
        
        bottomTabBar.addSubview(commentView)
        commentView.addSubview(separatorL)
        commentView.addSubview(commentIcon)
        commentView.addSubview(commentTitle)
        commentView.addSubview(separatorR)
        commentView.addSubview(commentBtn)
        
        bottomTabBar.addSubview(shareView)
        shareView.addSubview(shareIcon)
        shareView.addSubview(shareTitle)
        shareView.addSubview(shareBtn)
        
        view.addSubview(contentView)
    }
    
    // MARK: - layout and set page subviews
    func layoutPageSubviews() {
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view)
            make.height.equalTo(35)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(titleView)
            make.height.equalTo(20)
        }
        
        backBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleView).offset(10)
            make.centerY.equalTo(titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(bottomTabBar.snp_top)
        }
        
        bottomTabBar.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(35)
        }
        
        likeView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(bottomTabBar)
            make.width.equalTo(shareView.snp_width)
        }
        
        likeIcon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(24, 24))
            make.centerY.equalTo(self.likeView.snp_centerY)
            make.right.equalTo(self.likeView.snp_centerX).offset(-2)
        }
        
        likeTitle.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.likeIcon)
            make.left.equalTo(self.likeView.snp_centerX).offset(2)
            make.right.lessThanOrEqualTo(self.likeView)
        }
        
        likeBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(likeView)
        }
        
        commentView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(likeView)
            make.left.equalTo(likeView.snp_right)
            make.width.equalTo(likeView.snp_width)
        }
        
        separatorL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(commentView).offset(7)
            make.left.equalTo(commentView)
            make.bottom.equalTo(commentView).offset(-7)
            make.width.equalTo(1)
        }
        
        commentIcon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(24, 24))
            make.centerY.equalTo(self.commentView.snp_centerY)
            make.right.equalTo(self.commentView.snp_centerX).offset(-2)
        }
        
        commentTitle.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.commentIcon)
            make.left.equalTo(self.commentView.snp_centerX).offset(2)
            make.right.lessThanOrEqualTo(self.commentView)
        }
        
        separatorR.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(separatorL)
            make.right.equalTo(commentView)
            make.width.equalTo(1)
        }
        
        commentBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(commentView)
        }
        
        shareView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(commentView)
            make.left.equalTo(commentView.snp_right)
            make.right.equalTo(bottomTabBar)
            make.width.equalTo(commentView.snp_width)
        }
        
        shareIcon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(24, 24))
            make.centerY.equalTo(self.shareView.snp_centerY)
            make.right.equalTo(self.shareView.snp_centerX).offset(-2)
        }
        
        shareTitle.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.shareIcon)
            make.left.equalTo(self.shareView.snp_centerX).offset(2)
            make.right.lessThanOrEqualTo(self.shareView)
        }
        
        shareBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(shareView)
        }
    }
    
    func setPageSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        
        // 设置顶部导航栏
        switch segueId {
        case "Tata":
            titleView.backgroundColor = COLOR_TATA
            bottomTabBar.backgroundColor = COLOR_TATA
            
        case "cySegue":
            titleView.backgroundColor = COLOR_CY
            bottomTabBar.backgroundColor = COLOR_CY
            
        case "sjSegue":
            titleView.backgroundColor = COLOR_SJ
            bottomTabBar.backgroundColor = COLOR_SJ
            
        case "shSegue":
            titleView.backgroundColor = COLOR_SH
            bottomTabBar.backgroundColor = COLOR_SH
            
        default :
            break
        }
        titleLabel.text = contentTitle
        titleLabel.font = FONT_TITLE
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        backBtn.setBackgroundImage(UIImage(named: "upBackBtn"), forState: UIControlState.Normal)
        
        // 设置内容view
        let articleId = articleJson["ID"].stringValue
        let url = NSURL(string: "http://112.74.192.226/ios/article_detail?id=\(articleId)")
        let request = NSURLRequest(URL: url!)
        
        contentView.loadRequest(request)
        contentView.delegate = self
        contentView.scalesPageToFit = true
        
        // 设置底部操作栏
        likeIcon.image = UIImage(named: "downCollect")
        likeTitle.text = "点赞"
        likeTitle.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
        likeTitle.textColor = UIColor.whiteColor()
        
        separatorL.backgroundColor = UIColor.whiteColor()
        separatorR.backgroundColor = UIColor.whiteColor()
        
        commentIcon.image = UIImage(named: "downCollect")
        commentTitle.text = "评论"
        commentTitle.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
        commentTitle.textColor = UIColor.whiteColor()
        
        shareIcon.image = UIImage(named: "downCollect")
        shareTitle.text = "分享"
        shareTitle.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
        shareTitle.textColor = UIColor.whiteColor()
    }
    
    func setPageEvents() {
        backBtn.addTarget(self, action: #selector(backToUpLevel), forControlEvents: UIControlEvents.TouchUpInside)
        
        likeBtn.addTarget(self, action: #selector(like), forControlEvents: UIControlEvents.TouchUpInside)
        commentBtn.addTarget(self, action: #selector(comment), forControlEvents: UIControlEvents.TouchUpInside)
        shareBtn.addTarget(self, action: #selector(share), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - event response
    func backToUpLevel() {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func like() {
        print(1)
    }
    
    func comment() {
        print(2)
    }
    
    func share() {
        print(3)
    }
}
