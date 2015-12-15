//
//  CommentTableViewCell.swift
//  Arita
//
//  Created by DcBunny on 15/9/24.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell
{
    let txImage = UIImageView()
    let nicknameLabel = UILabel()
    let timeLabel = UILabel()
//    let timeImage = UIImageView()
    let commentLabel = UILabel()
    
    //MARK: - life methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.txImage)
        self.contentView.addSubview(self.nicknameLabel)
        self.contentView.addSubview(self.timeLabel)
//        self.contentView.addSubview(self.timeImage)
        self.contentView.addSubview(self.commentLabel)
        
        self.layoutCellSubviews()
        self.setupCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func layoutCellSubviews() {
        self.txImage.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(40, 40))
            make.top.left.equalTo(self.contentView).offset(15)
        }
        
        self.nicknameLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.txImage.snp_right).offset(15)
            make.right.equalTo(self.timeLabel.snp_left)
        }
        
        self.timeLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(65, 20))
            make.top.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
        }
        
//        self.timeImage.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(10, 10))
//            make.centerY.equalTo(self.timeLabel.snp_centerY)
//            make.right.equalTo(self.timeLabel.snp_left)
//        }
        
        self.commentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.nicknameLabel.snp_bottom).offset(5)
            make.left.equalTo(self.txImage.snp_right).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
//            make.bottom.equalTo(self.contentView).offset(-15)
        }
    }
    
    func setupCellSubviews() {
        self.txImage.layer.masksToBounds = true
        self.txImage.layer.cornerRadius = 20
        self.txImage.backgroundColor = UIColor.blackColor()
        
        self.nicknameLabel.text = "An user nickname"
        self.nicknameLabel.font = UIFont.systemFontOfSize(13)
        self.nicknameLabel.textColor = UIColor(red: 34 / 255.0, green: 34 / 255.0, blue: 34 / 255.0, alpha: 1.0)
        
        self.timeLabel.text = "xx-xx xx:xx"
        self.timeLabel.font = UIFont.systemFontOfSize(10)
        self.timeLabel.textColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
        self.timeLabel.textAlignment = NSTextAlignment.Right
        
//        self.timeImage.image = UIImage(named: "time")
        
        self.commentLabel.text = "我只是想试一下特别长的评论是如何显示的，其实没有别的意思，哇咔咔～～！"
        self.commentLabel.font = UIFont.systemFontOfSize(13)
        self.commentLabel.textColor = UIColor(red: 119 / 255.0, green: 119 / 255.0, blue: 119 / 255.0, alpha: 1.0)
        self.commentLabel.numberOfLines = 0
        self.commentLabel.sizeToFit()
    }
}
