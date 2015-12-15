//
//  LikeArticleCell.swift
//  Arita
//
//  Created by DcBunny on 15/9/8.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit

class LikeArticleCell: UITableViewCell
{
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    
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
