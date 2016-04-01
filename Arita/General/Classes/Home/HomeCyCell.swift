//
//  HomeCyCell.swift
//  Arita
//
//  Created by DcBunny on 16/4/1.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeCyCell: UITableViewCell
{
    private let cellView = UIView()
    
    let cyCMSView1 = CMSCoinView()
    let cyBtn1 = UIButton()
    
    let cyCMSView2 = CMSCoinView()
    let cyBtn2 = UIButton()
    
    let cyCMSView3 = CMSCoinView()
    let cyBtn3 = UIButton()
    
    private let cyTag = UIImageView()
    
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
        
        cellView.addSubview(cyCMSView1)
        cellView.addSubview(cyBtn1)
        
        cellView.addSubview(cyCMSView2)
        cellView.addSubview(cyBtn2)
        
        cellView.addSubview(cyCMSView3)
        cellView.addSubview(cyBtn3)
        
        cellView.addSubview(cyTag)
    }
    
    func layoutCellSubviews() {
        cellView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
        
        cyCMSView1.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(cellView)
            make.right.equalTo(cyCMSView3.snp_left).offset(-5)
            make.height.equalTo(cyCMSView1.snp_width)
        }
        
        cyBtn1.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(cyCMSView1)
        }
        
        cyCMSView2.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(cyCMSView1)
            make.bottom.equalTo(cellView)
            make.height.equalTo(cyCMSView2.snp_width)
        }
        
        cyBtn2.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(cyCMSView2)
        }
        
        cyCMSView3.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(cellView)
            make.width.equalTo(cyCMSView3.snp_height)
        }
        
        cyBtn3.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(cyCMSView3)
        }
        
        cyTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cellView)
            make.right.equalTo(cellView).offset(-10)
            make.size.equalTo(CGSizeMake(35, 22))
        }
    }
    
    func configCellSubviews() {
        contentView.backgroundColor = UIColor.whiteColor()
        cellView.backgroundColor = UIColor.clearColor()
        
        cyTag.image = UIImage(named: "cyLabel")
        
        cyCMSView1.spinTime = 1.0
        cyCMSView2.spinTime = 1.0
        cyCMSView3.spinTime = 1.0
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
            cyCMSView1.flip()
            
        case 1:
            cyCMSView2.flip()
            
        default:
            cyCMSView3.flip()
        }
    }
}
