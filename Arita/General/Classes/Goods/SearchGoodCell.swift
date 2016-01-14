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
        self.cellView.addSubview(self.goodPrice)
    }
    
    func layoutCellSubviews() {
        self.cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        self.goodImage.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self.cellView)
            make.width.equalTo(100)
        }
        
        self.goodTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.cellView).offset(15)
            make.left.equalTo(self.goodImage.snp_right).offset(10)
            make.right.equalTo(self.cellView).offset(-10)
            make.height.equalTo(40)
        }
        
        self.goodPrice.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.goodTitle)
            make.bottom.equalTo(self.cellView).offset(-15)
            make.height.equalTo(15)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = COLOR_BACKGROUND
        
        self.cellView.backgroundColor = UIColor.whiteColor()
        
        self.goodTitle.font = UIFont.systemFontOfSize(14)
        self.goodTitle.numberOfLines = 2
        
        self.goodPrice.textColor = COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR
        self.goodPrice.font = UIFont.boldSystemFontOfSize(13)
    }
}
