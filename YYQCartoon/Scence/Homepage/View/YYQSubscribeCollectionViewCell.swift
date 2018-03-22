//
//  YYQSubscribeCollectionViewCell.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/22.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import Kingfisher

class YYQSubscribeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setComic(model:Comic)  {


        titleLabel.text = model.name

        self.mainImageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.cover!)!),
                                       placeholder: UIImage(named:"normal_placeholder_h"),
                                       options: nil,
                                       progressBlock: nil,
                                       completionHandler: nil)
    }
}
