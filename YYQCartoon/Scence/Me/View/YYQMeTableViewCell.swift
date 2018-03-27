//
//  YYQMeTableViewCell.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/27.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import SnapKit

class YYQMeTableViewCell: UITableViewCell {

    var titleLabel:UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.textColor = UIColor.black
        addSubview(titleLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 30))
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
extension YYQMeTableViewCell: Configurable {


    func config(item:Any) {

        guard let items = item as? String else {
            return
        }
        self.titleLabel?.text = items

    }
}
