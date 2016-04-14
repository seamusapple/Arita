//
//  DailyCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/11.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    
    let cellView = UIView()
    
    let orderLabel = UILabel()
    let titleLabel = UILabel()
    let tataImage = UIImageView()
    let infoLabel = UILabel()
    
    //MARK: - life methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addCellSubviews()
        layoutCellSubviews()
        configCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup page subviews
    func addCellSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addSubview(orderLabel)
        cellView.addSubview(titleLabel)
        cellView.addSubview(tataImage)
        cellView.addSubview(infoLabel)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.left.bottom.right.equalTo(contentView)
        }
        
        orderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView).offset(15)
            make.left.equalTo(cellView).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(orderLabel)
            make.left.equalTo(orderLabel.snp_right).offset(5)
            make.right.equalTo(cellView).offset(-10)
        }
        
        tataImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(orderLabel.snp_bottom).offset(15)
            make.left.equalTo(cellView).offset(10)
            make.right.equalTo(cellView).offset(-10)
            let width = SCREEN_WIDTH - 20
            make.height.equalTo(width * 2 / 3)
        }
        
        infoLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tataImage.snp_bottom).offset(15)
            make.left.right.equalTo(tataImage)
            make.height.equalTo(50)
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = COLOR_BACKGROUND
        cellView.backgroundColor = UIColor.whiteColor()
        
        orderLabel.font = UIFont.systemFontOfSize(22)
        orderLabel.textColor = UIColor.whiteColor()
        orderLabel.backgroundColor = COLOR_TATA
        orderLabel.textAlignment = NSTextAlignment.Center
        orderLabel.layer.masksToBounds = true
        orderLabel.layer.cornerRadius = 15
        
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = COLOR_TATA
        
        infoLabel.numberOfLines = 3
        infoLabel.textColor = COLOR_INFO
        infoLabel.font = UIFont.systemFontOfSize(11)
    }
}
