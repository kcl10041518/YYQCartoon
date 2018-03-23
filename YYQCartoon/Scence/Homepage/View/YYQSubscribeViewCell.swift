//
//  YYQSubscribeViewCell.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/22.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import Kingfisher

class YYQSubscribeViewCell: UITableViewCell {

    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var collectLayout: UICollectionViewFlowLayout!

    /// 可以是对外传进来的数据类型
    var model:AnyObject?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectView.delegate = self
        self.collectView.dataSource = self
        self.collectView.backgroundColor = UIColor.lightText
        self.collectView.register(UINib.init(nibName: "YYQSubscribeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YYQSubscribeCollectionViewCell")
        self.collectLayout.itemSize = CGSize(width: (ScreenWidth-50)/3, height: 220)
        self.collectLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectView.isScrollEnabled = false
        // Initialization code
    }


    //    MARK: VIP Model
    func setVipModel(model:Vip)  {

        self.model = model as AnyObject
        sectionLabel.text = model.itemTitle
        self.iconImageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.titleIconUrl!)!),
                                       placeholder: UIImage(named:"normal_placeholder_h"),
                                       options: nil,
                                       progressBlock: nil,
                                       completionHandler: nil)
    }

    //    MARK: 订阅Model
    func setModel(model:Subscribe)  {

        self.model = model as AnyObject
        sectionLabel.text = model.itemTitle
        self.iconImageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.titleIconUrl!)!),
                                       placeholder: UIImage(named:"normal_placeholder_h"),
                                       options: nil,
                                       progressBlock: nil,
                                       completionHandler: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: UICollectionViewDelegate UICollectionViewDataSource
extension YYQSubscribeViewCell:UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if model is Subscribe {
            let model = self.model as! Subscribe
            return (model.comics?.count)!
        }else if model is Vip{
            let model = self.model as! Vip
            return (model.comics?.count)!
        }else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "YYQSubscribeCollectionViewCell", for: indexPath) as! YYQSubscribeCollectionViewCell

        if model is Subscribe {

            let model = self.model as! Subscribe
            cell.setComic(model: (model.comics![indexPath.row]))

        }else if model is Vip{

            let model = self.model as! Vip
            cell.setComic(model: (model.comics![indexPath.row]))
        }

        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: ScreenWidth/3, height: 280)
    }

     //每个分区的内边距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        return UIEdgeInsetsMake(10, 10, 10, 10);
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("select item section=\(indexPath.section) row=\(indexPath.row)")
    }
}
