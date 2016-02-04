//
//  SearchGoodCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/14.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class SearchGoodCell: UITableViewCell
{
    var cellView = UIView()
    var goodImage = UIImageView()
    var goodTitle = UILabel()
    var goodInfo = UILabel()
    var goodPrice = UILabel()
    
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
        self.cellView.addSubview(self.goodInfo)
        self.cellView.addSubview(self.goodPrice)
    }
    
    func layoutCellSubviews() {
        self.cellView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.left.bottom.right.equalTo(self.contentView)
        }
        
        self.goodImage.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cellView).offset(10)
            make.bottom.equalTo(self.cellView).offset(-10)
            make.width.equalTo(100)
        }
        
        self.goodTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodImage.snp_top).offset(10)
            make.left.equalTo(self.goodImage.snp_right).offset(10)
            make.right.equalTo(self.cellView).offset(-10)
            make.height.equalTo(20)
        }
        
        self.goodInfo.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodTitle.snp_bottom).offset(5)
            make.left.right.equalTo(self.goodTitle)
            make.height.equalTo(50)
        }
        
        self.goodPrice.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.goodInfo.snp_bottom).offset(5)
            make.right.equalTo(self.goodInfo.snp_right)
            make.bottom.equalTo(self.goodImage.snp_bottom)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = COLOR_BACKGROUND
        
        self.cellView.backgroundColor = UIColor.whiteColor()
        
        self.goodTitle.font = UIFont.systemFontOfSize(14)
        
        self.goodInfo.numberOfLines = 3
        self.goodInfo.textColor = COLOR_INFO
        self.goodInfo.font = UIFont.systemFontOfSize(11)
        
        self.goodPrice.textColor = COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR
        self.goodPrice.font = UIFont.boldSystemFontOfSize(13)
    }
}
