//
//  HomeLpCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/1.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeLpCell: UITableViewCell
{
    private let cellView = UIView()
    
    let lpCMSView1 = CMSCoinView()
    let lpBtn1 = UIButton()
    
    let lpCMSView2 = CMSCoinView()
    let lpBtn2 = UIButton()
    
    let lpCMSView3 = CMSCoinView()
    let lpBtn3 = UIButton()
    
    let lpCMSView4 = CMSCoinView()
    let lpBtn4 = UIButton()
    
    let lpCMSView5 = CMSCoinView()
    let lpBtn5 = UIButton()
    
    let lpCMSView6 = CMSCoinView()
    let lpBtn6 = UIButton()
    
    private let lpTag = UIImageView()
    
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
        
        cellView.addSubview(lpCMSView1)
        cellView.addSubview(lpBtn1)
        
        cellView.addSubview(lpCMSView2)
        cellView.addSubview(lpBtn2)
        
        cellView.addSubview(lpCMSView3)
        cellView.addSubview(lpBtn3)
        
        cellView.addSubview(lpCMSView4)
        cellView.addSubview(lpBtn4)
        
        cellView.addSubview(lpCMSView5)
        cellView.addSubview(lpBtn5)
        
        cellView.addSubview(lpCMSView6)
        cellView.addSubview(lpBtn6)
        
        cellView.addSubview(lpTag)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(contentView).offset(10)
            make.right.bottom.equalTo(contentView).offset(-10)
        }
        
        lpCMSView1.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(cellView)
            make.right.equalTo(cellView.snp_centerX).offset(-2.5)
            make.height.equalTo(lpCMSView1.snp_width)
        }
        
        lpBtn1.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView1)
        }
        
        lpCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(cellView)
            make.right.equalTo(lpCMSView1.snp_centerX).offset(-2.5)
            make.height.equalTo(lpCMSView2.snp_width)
        }
        
        lpBtn2.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView2)
        }
        
        lpCMSView3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lpCMSView2)
            make.left.equalTo(lpCMSView2.snp_right).offset(5)
            make.bottom.equalTo(cellView)
            make.right.equalTo(lpCMSView1)
        }
        
        lpBtn3.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView3)
        }
        
        lpCMSView4.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView)
            make.right.equalTo(lpCMSView5.snp_left).offset(-5)
            make.bottom.equalTo(lpCMSView5)
            make.left.equalTo(lpCMSView6)
        }
        
        lpBtn4.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView4)
        }
        
        lpCMSView5.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(cellView)
            make.left.equalTo(lpCMSView6.snp_centerX).offset(2.5)
            make.height.equalTo(lpCMSView2.snp_width)
        }
        
        lpBtn5.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView5)
        }
        
        lpCMSView6.snp_makeConstraints { (make) -> Void in
            make.bottom.right.equalTo(cellView)
            make.left.equalTo(cellView.snp_centerX).offset(2.5)
            make.height.equalTo(lpCMSView1.snp_width)
        }
        
        lpBtn6.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(lpCMSView6)
        }
        
        lpTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView)
            make.left.equalTo(cellView).offset(10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = UIColor.whiteColor()
        cellView.backgroundColor = UIColor.clearColor()
        
        lpTag.image = UIImage(named: "lpLable")
        
        lpCMSView1.spinTime = 1.0
        lpCMSView2.spinTime = 1.0
        lpCMSView3.spinTime = 1.0
        lpCMSView4.spinTime = 1.0
        lpCMSView5.spinTime = 1.0
        lpCMSView6.spinTime = 1.0
    }
    
    func startFlip() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.flipTimer), userInfo: nil, repeats: true)
    }
    
    func stopFlip() {
        timer!.invalidate()
        timer = nil
    }
    
    func flipTimer() {
        let random = Int(arc4random() % 6)
        switch random {
        case 0:
            lpCMSView1.flip()
            
        case 1:
            lpCMSView2.flip()
            
        case 2:
            lpCMSView3.flip()
            
        case 3:
            lpCMSView4.flip()
            
        case 4:
            lpCMSView5.flip()
            
        default:
            lpCMSView6.flip()
        }
    }
}
