//
//  YYQStrRecmdViewCell.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/26.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQStrRecmdViewCell: UITableViewCell {

    @IBOutlet weak var collectLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var subImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
