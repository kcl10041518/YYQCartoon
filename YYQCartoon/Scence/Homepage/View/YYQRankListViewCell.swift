//
//  YYQRankListViewCell.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/22.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import SnapKit

class YYQRankListViewCell: UITableViewCell {

    var iconImageView:UIImageView!
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()


        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconImageView = UIImageView()
        self.addSubview(iconImageView!)

        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel!)

        subtitleLabel = UILabel()
        subtitleLabel?.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = UIColor.lightGray
        subtitleLabel.numberOfLines = 2
        self.addSubview(subtitleLabel!)

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        iconImageView.snp.makeConstraints({ (make) in
            make.top.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(120)
        })
        titleLabel.snp.makeConstraints { (make) in

            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }

        subtitleLabel.snp.makeConstraints { (make) in

            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-10)
        }
    }




    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
