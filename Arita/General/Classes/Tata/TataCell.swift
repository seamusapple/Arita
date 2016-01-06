//
//  TataCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/2.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class TataCell: UITableViewCell
{
    var cellView = UIView()
    
    var tataImage = UIImageView()
    
    var timestampIcon = UIImageView()
    var timestamp = UILabel()
    
    var tataTitle = UILabel()
    
    var tataInfo = UILabel()
    
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
        
        self.cellView.addSubview(self.tataImage)
        
        self.cellView.addSubview(self.timestampIcon)
        self.timestampIcon.addSubview(self.timestamp)
        
        self.cellView.addSubview(self.tataTitle)
        
        self.cellView.addSubview(self.tataInfo)
    }
    
    func layoutCellSubviews() {
        self.cellView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.left.bottom.right.equalTo(self.contentView)
        }
        
        self.tataImage.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cellView).offset(10)
            make.right.equalTo(self.cellView).offset(-10)
            let width = SCREEN_WIDTH - 20
            make.height.equalTo(width * 2 / 3)
        }
        
        self.timestampIcon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(68, 25))
            make.left.equalTo(self.cellView)
            make.top.equalTo(self.cellView).offset(20)
        }
        
        self.timestamp.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.timestampIcon).inset(0)
        }
        
        self.tataTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tataImage.snp_bottom).offset(10)
            make.left.right.equalTo(self.tataImage)
            make.height.equalTo(20)
        }
        
        self.tataInfo.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.tataTitle.snp_bottom).offset(10)
            make.left.right.equalTo(self.tataTitle)
            make.height.equalTo(50)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = COLOR_BACKGROUND
        
        self.cellView.backgroundColor = UIColor.whiteColor()
        
        self.timestampIcon.image = UIImage(named: "tata_time_icon")
        
        self.timestamp.textColor = UIColor.whiteColor()
        self.timestamp.font = UIFont.boldSystemFontOfSize(13)
        self.timestamp.textAlignment = NSTextAlignment.Center
        
        self.tataTitle.font = UIFont.systemFontOfSize(14)
        
        self.tataInfo.numberOfLines = 3
        self.tataInfo.textColor = UIColor(red: 119 / 255.0, green: 119 / 255.0, blue: 119 / 255.0, alpha: 1.0)
        self.tataInfo.font = UIFont.systemFontOfSize(11)
    }
}
