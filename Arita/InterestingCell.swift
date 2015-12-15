//
//  InterestingCell.swift
//  Arita
//
//  Created by DcBunny on 15/8/2.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit

class InterestingCell: UITableViewCell
{

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
