//
//  HomeShCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/1.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeShCell: UITableViewCell
{
    private let cellView = UIView()
    
    let shCMSView1 = CMSCoinView()
    let shBtn1 = UIButton()
    
    let shCMSView2 = CMSCoinView()
    let shBtn2 = UIButton()
    
    let shCMSView3 = CMSCoinView()
    let shBtn3 = UIButton()
    
    private let shTag = UIImageView()
    
    private var timer: NSTimer?
    
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
        
        cellView.addSubview(shCMSView1)
        cellView.addSubview(shBtn1)
        
        cellView.addSubview(shCMSView2)
        cellView.addSubview(shBtn2)
        
        cellView.addSubview(shCMSView3)
        cellView.addSubview(shBtn3)
        
        cellView.addSubview(shTag)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
        
        shCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(cellView)
            make.right.equalTo(shCMSView3.snp_left).offset(-5)
            make.height.equalTo(shCMSView1.snp_width)
        }
        
        shBtn1.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(shCMSView1)
        }
        
        shCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(shCMSView1)
            make.bottom.equalTo(cellView)
            make.height.equalTo(shCMSView2.snp_width)
        }
        
        shBtn2.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(shCMSView2)
        }
        
        shCMSView3.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(cellView)
            make.width.equalTo(shCMSView3.snp_height)
        }
        
        shBtn3.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(shCMSView3)
        }
        
        shTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView)
            make.right.equalTo(cellView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = UIColor.whiteColor()
        cellView.backgroundColor = UIColor.clearColor()
        
        shTag.image = UIImage(named: "shLabel")
        
        shCMSView1.spinTime = 1.0
        shCMSView2.spinTime = 1.0
        shCMSView3.spinTime = 1.0
    }
    
    func startFlip() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.flipTimer), userInfo: nil, repeats: true)
    }
    
    func stopFlip() {
        timer!.invalidate()
        timer = nil
    }
    
    func flipTimer() {
        let random = Int(arc4random() % 3)
        switch random {
        case 0:
            shCMSView1.flip()
            
        case 1:
            shCMSView2.flip()
            
        default:
            shCMSView3.flip()
        }
    }
}
