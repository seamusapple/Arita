//
//  ArticleCell.swift
//  Arita
//
//  Created by DcBunny on 16/1/6.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell
{
    var cellView = UIView()
    var articleImage = UIImageView()
    var articleTitle = UILabel()
    var articleInfo = UILabel()
    
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
        self.cellView.addSubview(self.articleImage)
        self.cellView.addSubview(self.articleTitle)
        self.cellView.addSubview(self.articleInfo)
    }
    
    func layoutCellSubviews() {
        self.cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.articleImage.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.cellView).offset(10)
            make.right.equalTo(self.cellView).offset(-10)
            let width = SCREEN_WIDTH - 20
            make.height.equalTo(width * 2 / 3)
        }
        
        self.articleTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.articleImage.snp_bottom).offset(10)
            make.left.right.equalTo(self.articleImage)
            make.height.equalTo(20)
        }
        
        self.articleInfo.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.articleTitle.snp_bottom).offset(10)
            make.left.right.equalTo(self.articleTitle)
            make.height.equalTo(50)
        }
    }
    
    func configCellSubviews() {
        self.contentView.backgroundColor = COLOR_BACKGROUND
        
        self.cellView.backgroundColor = UIColor.whiteColor()
        
        self.articleTitle.font = UIFont.systemFontOfSize(14)
        
        self.articleInfo.numberOfLines = 3
        self.articleInfo.textColor = COLOR_INFO
        self.articleInfo.font = UIFont.systemFontOfSize(11)
    }
}
