//
//  HomeSjCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/1.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeSjCell: UITableViewCell
{
    private let cellView = UIView()
    
    let sjCMSView1 = CMSCoinView()
    let sjBtn1 = UIButton()
    
    let sjCMSView2 = CMSCoinView()
    let sjBtn2 = UIButton()
    
    let sjCMSView3 = CMSCoinView()
    let sjBtn3 = UIButton()
    
    private let sjTag = UIImageView()
    
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
        
        cellView.addSubview(sjCMSView1)
        cellView.addSubview(sjBtn1)
        
        cellView.addSubview(sjCMSView2)
        cellView.addSubview(sjBtn2)
        
        cellView.addSubview(sjCMSView3)
        cellView.addSubview(sjBtn3)
        
        cellView.addSubview(sjTag)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
        
        sjCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(cellView)
            make.width.equalTo(sjCMSView1.snp_height)
        }
        
        sjBtn1.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(sjCMSView1)
        }
        
        sjCMSView2.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(cellView)
            make.left.equalTo(sjCMSView1.snp_right).offset(5)
            make.height.equalTo(sjCMSView2.snp_width)
        }
        
        sjBtn2.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(sjCMSView2)
        }
        
        sjCMSView3.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(sjCMSView2)
            make.bottom.equalTo(cellView)
            make.height.equalTo(sjCMSView3.snp_width)
        }
        
        sjBtn3.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(sjCMSView3)
        }
        
        sjTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView)
            make.left.equalTo(cellView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = UIColor.whiteColor()
        cellView.backgroundColor = UIColor.clearColor()
        
        sjTag.image = UIImage(named: "sjLabel")
        
        sjCMSView1.spinTime = 1.0
        sjCMSView2.spinTime = 1.0
        sjCMSView3.spinTime = 1.0
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
            sjCMSView1.flip()
            
        case 1:
            sjCMSView2.flip()
            
        default:
            sjCMSView3.flip()
        }
    }
}
