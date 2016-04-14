//
//  DailyGoodsCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/13.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class DailyGoodsCell: UITableViewCell {
    
    var cellView = UIView()
    var goodImage = UIImageView()
    var goodTitle = UILabel()
    //    var goodInfo = UILabel()
    //    var separateLine = UIView()
    var goodPrice = UILabel()
    //    private var likeIcon = UIImageView()
    //    var likeNum = UILabel()
    var dateLabel = UILabel()
    
    //MARK: - life methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addCellSubviews()
        self.layoutCellSubviews()
        self.configCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup page subviews
    func addCellSubviews() {
        self.contentView.addSubview(self.cellView)
        self.cellView.addSubview(self.goodImage)
        self.cellView.addSubview(self.goodTitle)
        //        self.cellView.addSubview(self.goodInfo)
        //        self.cellView.addSubview(self.separateLine)
        self.cellView.addSubview(self.goodPrice)
        //        self.cellView.addSubview(self.likeIcon)
        //        self.cellView.addSubview(self.likeNum)
        self.cellView.addSubview(self.dateLabel)
    }
    
    func layoutCellSubviews() {
        self.cellView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.left.bottom.right.equalTo(self.contentView)
        }
        
        self.goodImage.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cellView).offset(10)
            make.right.equalTo(self.cellView).offset(-10)
            make.height.equalTo(self.goodImage.snp_width)
        }
        
        self.goodTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodImage.snp_bottom).offset(10)
            make.left.right.equalTo(self.goodImage)
            make.height.equalTo(20)
        }
        
        //        self.goodInfo.snp_makeConstraints { (make) -> Void in
        //            make.top.equalTo(self.goodTitle.snp_bottom).offset(10)
        //            make.left.right.equalTo(self.goodTitle)
        //            make.height.equalTo(50)
        //        }
        
        //        self.separateLine.snp_makeConstraints { (make) -> Void in
        //            make.top.equalTo(self.goodInfo.snp_bottom).offset(10)
        //            make.left.right.equalTo(self.goodInfo)
        //            make.height.equalTo(1)
        //        }
        
        self.goodPrice.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodTitle.snp_bottom).offset(10)
            make.left.equalTo(self.goodTitle)
            make.height.equalTo(15)
        }
        
        //        self.likeNum.snp_makeConstraints { (make) -> Void in
        //            make.top.equalTo(self.separateLine.snp_bottom).offset(5)
        //            make.right.equalTo(self.separateLine)
        //            make.height.equalTo(15)
        //        }
        //
        //        self.likeIcon.snp_makeConstraints { (make) -> Void in
        //            make.size.equalTo(CGSizeMake(10, 10))
        //            make.centerY.equalTo(self.likeNum.snp_centerY)
        //            make.right.equalTo(self.likeNum.snp_left).offset(-5)
        //        }
        
        self.dateLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodPrice)
            make.right.equalTo(self.goodTitle)
            make.height.equalTo(15)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = COLOR_BACKGROUND
        
        self.cellView.backgroundColor = UIColor.whiteColor()
        
        self.goodTitle.font = UIFont.systemFontOfSize(14)
        
        //        self.goodInfo.numberOfLines = 3
        //        self.goodInfo.textColor = COLOR_INFO
        //        self.goodInfo.font = UIFont.systemFontOfSize(11)
        //
        //        self.separateLine.backgroundColor = COLOR_GOODS_SEPARATE
        
        self.goodPrice.textColor = COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR
        self.goodPrice.font = UIFont.boldSystemFontOfSize(13)
        
        //        self.likeIcon.image = UIImage(named: "good_like_icon")
        //
        //        self.likeNum.textColor = COLOR_INFO
        //        self.likeNum.textAlignment = NSTextAlignment.Right
        //        self.likeNum.font = UIFont.systemFontOfSize(13)
        
        self.dateLabel.textColor = COLOR_INFO
        self.dateLabel.textAlignment = NSTextAlignment.Right
        self.dateLabel.font = UIFont.systemFontOfSize(13)
    }
}
