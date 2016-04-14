//
//  TataCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/2.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class TataCell: UITableViewCell {
    
    private let cellView = UIView()
    
    let dayLabel = UILabel()
    let dayOfWeekLabel = UILabel()
    let yearAndMonthLabel = UILabel()
    
    private let separator = UIView()
    
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
        
        cellView.addSubview(dayLabel)
        cellView.addSubview(dayOfWeekLabel)
        cellView.addSubview(yearAndMonthLabel)
        
        cellView.addSubview(separator)
        
        cellView.addSubview(titleLabel)
        cellView.addSubview(tataImage)
        cellView.addSubview(infoLabel)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.left.bottom.right.equalTo(contentView)
        }
        
        dayLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView).offset(15)
            make.left.equalTo(cellView).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        dayOfWeekLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dayLabel)
            make.left.equalTo(dayLabel.snp_right)
            make.bottom.equalTo(dayLabel.snp_centerY)
            make.width.equalTo(50)
        }
        
        yearAndMonthLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dayLabel.snp_centerY)
            make.left.equalTo(dayLabel.snp_right)
            make.bottom.equalTo(dayLabel.snp_bottom)
            make.right.equalTo(dayOfWeekLabel)
        }
        
        separator.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(dayLabel)
            make.left.equalTo(dayOfWeekLabel.snp_right).offset(5)
            make.width.equalTo(1)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dayLabel)
            make.left.equalTo(separator.snp_right).offset(5)
            make.bottom.equalTo(dayLabel)
            make.right.equalTo(cellView).offset(-10)
        }
        
        tataImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dayLabel.snp_bottom).offset(15)
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
        
        dayLabel.font = UIFont.systemFontOfSize(28)
        dayLabel.textColor = COLOR_TATA
        dayLabel.textAlignment = NSTextAlignment.Center
        
        dayOfWeekLabel.font = UIFont.systemFontOfSize(14)
        dayOfWeekLabel.textColor = titleColor
        dayOfWeekLabel.textAlignment = NSTextAlignment.Center
        
        yearAndMonthLabel.font = UIFont.systemFontOfSize(11)
        yearAndMonthLabel.textColor = titleColor
        yearAndMonthLabel.textAlignment = NSTextAlignment.Center
        
        separator.backgroundColor = titleColor
        
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.textColor = titleColor
        titleLabel.numberOfLines = 2
        
        infoLabel.textColor = COLOR_INFO
        infoLabel.font = UIFont.systemFontOfSize(11)
        infoLabel.numberOfLines = 3
    }
}
