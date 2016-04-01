//
//  HomeTataCell.swift
//  Arita
//
//  Created by DcBunny on 16/3/29.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeTataCell: UITableViewCell
{
    private let cellView = UIView()
    let tataImage = UIImageView()
    private let tataTag = UIImageView()
    private let titleBg = UIImageView()
    let tataTitle = UILabel()
    let tataBtn = UIButton()
    
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
        cellView.addSubview(tataImage)
        cellView.addSubview(tataTag)
        cellView.addSubview(titleBg)
        cellView.addSubview(tataTitle)
        cellView.addSubview(tataBtn)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
        
        tataImage.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(cellView)
//            make.top.left.equalTo(cellView).offset(10)
//            make.right.equalTo(cellView).offset(-10)
//            let width = SCREEN_WIDTH - 20
//            make.height.equalTo(width * 2 / 3)
        }
        
        tataTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tataImage)
            make.left.equalTo(tataImage).offset(10)
            make.size.equalTo(CGSizeMake(45, 22))
        }
        
        titleBg.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(tataImage)
            make.height.equalTo(30)
        }
        
        tataTitle.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(titleBg).inset(UIEdgeInsetsMake(0, 10, 0, -10))
        }
        
        tataBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(tataImage)
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = UIColor.whiteColor()
        cellView.backgroundColor = UIColor.clearColor()
        
        tataTag.image = UIImage(named: "tataLabel")
        titleBg.image = UIImage(named: "tataLabelBg")
        
        tataTitle.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
        tataTitle.textColor = UIColor.whiteColor()
    }
}
