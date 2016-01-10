//
//  GoodsCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/10.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class GoodsCell: UICollectionViewCell
{
    var goodImage = UIImageView()
    var goodTitle = UILabel()
    var goodCategory = UILabel()
    var goodPrice = UILabel()
    
    //MARK: - life methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addCellSubviews()
        self.layoutCellSubviews()
        self.configCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup page subviews
    func addCellSubviews() {
        self.contentView.addSubview(self.goodImage)
        self.contentView.addSubview(self.goodTitle)
        self.contentView.addSubview(self.goodCategory)
        self.contentView.addSubview(self.goodPrice)
    }
    
    func layoutCellSubviews() {
        self.goodImage.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self.contentView).offset(5)
            make.height.equalTo(self.goodImage.snp_width)
        }
        
        self.goodTitle.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.goodImage)
            make.top.equalTo(self.goodImage.snp_bottom).offset(10)
            make.height.equalTo(30)
        }
        
        self.goodCategory.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.goodTitle)
            make.right.equalTo(self.goodTitle.snp_centerX)
            make.top.equalTo(self.goodTitle.snp_bottom).offset(9)
            make.height.equalTo(15)
        }
        
        self.goodPrice.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.goodTitle.snp_centerX)
            make.right.equalTo(self.goodTitle)
            make.top.equalTo(self.goodTitle.snp_bottom).offset(9)
            make.height.equalTo(15)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = UIColor.whiteColor()
        
        self.goodTitle.font = UIFont.systemFontOfSize(11)
        self.goodTitle.textColor = COLOR_GOODS_TITLE
        
        self.goodCategory.font = UIFont.systemFontOfSize(10)
        self.goodCategory.textColor = UIColor.blackColor()
        
        self.goodPrice.font = UIFont.boldSystemFontOfSize(10)
        self.goodPrice.textColor = COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR
    }
}
