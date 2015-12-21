//
//  TataTableCell.swift
//  Arita
//
//  Created by DcBunny on 15/7/22.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit

class TataNewsCell: UITableViewCell
{
    @IBOutlet weak var thumbnailOfNew: UIImageView!
    @IBOutlet weak var titleOfNew: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
