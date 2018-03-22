//
//  YYQRankListViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher


class YYQRankListViewController: YYQBaseViewController {


    let disposeBag = DisposeBag()

    let rankListObservable = Variable<[Rank]>([])

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.frame = self.view.bounds
        self.tableView.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.tableView)
        tableView.tableFooterView = UIView.init()
        tableView.rowHeight = 120
        tableView.register(YYQRankListViewCell.classForCoder(), forCellReuseIdentifier: "YYQRankListViewCell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)


        YYQRequest.getRankList()
            .subscribe(onNext: { (model) in

                self.rankListObservable.value = (model.data?.returnData?.rankinglist)!
                
            }).disposed(by: disposeBag)

        rankListObservable.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "YYQRankListViewCell", cellType: YYQRankListViewCell.self)){ (row ,model ,cell) in

                cell.iconImageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.cover!)!),
                                               placeholder: UIImage(named:"normal_placeholder_h"),
                                               options: nil,
                                               progressBlock: nil,
                                               completionHandler: nil)
                cell.titleLabel?.text = model.title!
                cell.subtitleLabel.text = model.subTitle!

        }.disposed(by: disposeBag)





        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension YYQRankListViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }


}
