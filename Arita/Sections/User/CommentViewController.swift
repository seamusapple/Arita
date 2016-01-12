//
//  CommentViewController.swift
//  Arita
//
//  Created by DcBunny on 15/9/24.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var articleId = ""
    var commentArray:[JSON] = []
    
    var titleView = UIView()
    var backBtn = UIButton()
    var titleLabel = UILabel()
    var splitLine = UIImageView()
    
    var commentTableView = UITableView()
    
    var bottomView = UIView()
    var txImage = UIImageView()
    var commentTextField = UITextField()
    var commentBtn = UIButton()
    
    let tapGesture = UITapGestureRecognizer()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // comment title
        self.view.addSubview(self.titleView)
        self.titleView.addSubview(self.backBtn)
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.splitLine)
        
        self.view.addSubview(self.commentTableView)
        
        // comment edit
        self.view.addSubview(self.bottomView)
        self.bottomView.addSubview(self.txImage)
        self.bottomView.addSubview(self.commentTextField)
        self.bottomView.addSubview(self.commentBtn)
        
        self.view.addGestureRecognizer(tapGesture)
        
        // setup page subviews
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setSubviewEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func layoutPageSubviews() {
        // comment title
        self.titleView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.left.right.equalTo(self.view)
        }
        
        self.backBtn.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(24)
            make.top.equalTo(self.titleView).offset(13)
            make.bottom.equalTo(self.titleView).offset(-13)
            make.left.equalTo(self.titleView).offset(15)
        }
        
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.top.equalTo(self.titleView).offset(10)
            make.bottom.equalTo(self.titleView).offset(-10)
            make.left.equalTo(self.backBtn.snp_right).offset(30)
        }
        
        self.splitLine.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(1)
            make.left.right.bottom.equalTo(self.titleView)
        }
        
        self.commentTableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleView.snp_bottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomView.snp_top)
        }
        
        // comment edit
        self.bottomView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(self.view)
        }
        
        self.txImage.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.top.equalTo(self.bottomView).offset(5)
            make.bottom.equalTo(self.bottomView).offset(-5)
            make.left.equalTo(self.bottomView).offset(15)
        }
        
        self.commentTextField.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.bottomView).offset(10)
            make.bottom.equalTo(self.bottomView).offset(-10)
            make.left.equalTo(self.txImage.snp_right).offset(15)
            make.right.equalTo(self.commentBtn.snp_left).offset(-15)
        }
        
        self.commentBtn.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(24)
            make.top.equalTo(self.bottomView).offset(13)
            make.bottom.equalTo(self.bottomView).offset(-13)
            make.right.equalTo(self.bottomView).offset(-30)
        }
    }
    
    func setPageSubviews() {
        // comment title
        self.titleView.backgroundColor = UIColor.whiteColor()
        self.backBtn.setImage(UIImage(named: "up_back02"), forState: UIControlState.Normal)
        self.splitLine.backgroundColor = COLOR_INFO
        self.titleLabel.font = UIFont.systemFontOfSize(13)
        self.titleLabel.textColor = COLOR_INFO
        
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            let parameters = [
                "articleID": self.articleId
            ]
            Alamofire.request(.GET, "http://112.74.192.226/ios/get_article_comments", parameters: parameters)
                .responseJSON { aRequest, aResponse, aJson in
                    self.getComment(aJson.value)
            }
        }
        
        self.commentTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // comment edit
        self.bottomView.backgroundColor = UIColor.whiteColor()
        let imageUrl = NSUserDefaults.standardUserDefaults().stringForKey("usericon")
        if (imageUrl != nil) {
            self.txImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "portrait"))
        } else {
            self.txImage.image = UIImage(named: "portrait")
        }
        self.txImage.layer.masksToBounds = true
        self.txImage.layer.cornerRadius = 20
        self.commentTextField.placeholder = "在这里说点什么吧"
        self.commentTextField.font = UIFont.systemFontOfSize(13)
        self.commentTextField.textColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
        self.commentBtn.setImage(UIImage(named: "down_discuss02"), forState: UIControlState.Normal)
    }
    
    func setSubviewEvents() {
        self.backBtn.addTarget(self, action: "backToArticle", forControlEvents: UIControlEvents.TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyboardWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        self.tapGesture.addTarget(self, action: Selector("hideKeyboard"))
        self.commentBtn.addTarget(self, action: Selector("sendComment"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        self.commentTableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "commentCell")
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "commentCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! CommentTableViewCell
        
        cell.commentLabel.text = self.commentArray[indexPath.row]["content"].string
        cell.nicknameLabel.text = self.commentArray[indexPath.row]["nickname"].string
        let dateOfComment = self.commentArray[indexPath.row]["time"].string
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(dateOfComment!)
        dateFormatter.dateFormat = "MM-dd HH:mm"
        cell.timeLabel.text = dateFormatter.stringFromDate(date!)
        let imageUrl = self.commentArray[indexPath.row]["head_img"].string
        cell.txImage.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "portrait"))
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    //MARK: - event response
    func backToArticle() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func keyboardWillChange(notification : NSNotification) {
        let info: NSDictionary = notification.userInfo!
        let duration = info.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.floatValue
        let beginKeyboardRect = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue
        let endKeyboardRect = info.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue
        let yOffset = (endKeyboardRect?.origin.y)! - (beginKeyboardRect?.origin.y)!
        var inputFieldRect = self.bottomView.frame
        inputFieldRect.origin.y += yOffset
        UIView.animateWithDuration(NSTimeInterval(duration!), animations: {
            self.bottomView.frame = inputFieldRect
        })
    }
    
    func hideKeyboard() {
        self.commentTextField.resignFirstResponder()
    }
    
    func sendComment() {
        let content = self.commentTextField.text!.stringByRemovingPercentEncoding
        if (content == nil || content == "") {
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        let articleId = self.articleId
        let parameters = [
            "userID": userId!,
            "content": content!,
            "articleID": articleId
        ]
        Alamofire.request(.POST, "http://112.74.192.226/ios/add_article_comments", parameters: parameters)
            .response { request, _, aJson, error in
                _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
                
                let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
                if userId != nil {
                    let parameters = [
                        "articleID": self.articleId
                    ]
                    Alamofire.request(.GET, "http://112.74.192.226/ios/get_article_comments", parameters: parameters)
                        .responseJSON { aRequest, aResponse, aJson in
                            self.getComment(aJson.value)
                    }
                }
        }
        self.commentTextField.text = ""
    }
    
    //MARK: - private methods
    func getComment(data: AnyObject?) {
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
        self.commentArray.removeAll()
        for id in tmpKeys {
            self.commentArray.append(tmpDic[id]!)
        }
        self.titleLabel.text = "评论 \(self.commentArray.count)"
        self.commentTableView.reloadData()
    }
}
