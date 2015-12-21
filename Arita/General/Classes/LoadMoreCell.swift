//
//  LoadMoreCell.swift
//  Arita
//
//  Created by DcBunny on 15/10/12.
//  Copyright © 2015年 DcBunny. All rights reserved.
//

import UIKit
import SnapKit

class LoadMoreCell: UITableViewCell
{
    let titleLabel = UILabel()
    
    //MARK: - life methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.layoutCellSubviews()
        self.setupCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutCellSubviews() {
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView)
            make.size.equalTo(CGSizeMake(100, 21))
        }
    }
    
    func setupCellSubviews() {
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.text = "加载更多"
        self.titleLabel.font = UIFont.systemFontOfSize(12)
        self.titleLabel.textColor = UIColor(red: 119 / 255.0, green: 119 / 255.0, blue: 119 / 255.0, alpha: 1.0)
    }
}
