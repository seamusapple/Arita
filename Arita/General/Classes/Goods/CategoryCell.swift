//
//  CategoryCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/10.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell
{
    var categoryIcon = UIImageView()
    var categoryTitle = UILabel()
    
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
        self.contentView.addSubview(self.categoryIcon)
        self.contentView.addSubview(self.categoryTitle)
    }
    
    func layoutCellSubviews() {
        self.categoryIcon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(50, 45))
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.top.equalTo(self.contentView).offset(10)
        }
        
        self.categoryTitle.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.categoryIcon)
            make.top.equalTo(self.categoryIcon.snp_bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    func configCellSubviews() {
        self.categoryTitle.font = UIFont.systemFontOfSize(14)
        self.categoryTitle.textColor = COLOR_GOODS_CATEGORY_TEXT
        self.categoryTitle.textAlignment = NSTextAlignment.Center
    }
}