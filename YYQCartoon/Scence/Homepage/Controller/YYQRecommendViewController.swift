//
//  YYQRecommendViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Kingfisher

class YYQRecommendViewController: YYQBaseViewController {

    // 轮播图数据源
    var comicLists = [ComicList]()
    var gallerys = [GalleryItem]()
    let disposeBag = DisposeBag()

    lazy var tableView: UITableView = {

        let tableView = UITableView()
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    var topScrollView:YYQScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getNetworkData()
        // Do any additional setup after loading the view.
    }
    func setUI() {

        topScrollView = YYQScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        self.tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-kNavigationBarHeight-49)
        self.tableView.tableHeaderView = topScrollView
        self.view.addSubview(self.tableView)

    }
    func getNetworkData() {

        YYQRequest.getRecommendList()
            .subscribe(onNext: { (model) in

                self.topScrollView?.setUpScrollView(array: (model.data?.returnData?.galleryItems)!)
//                self.gallerys = (model.data?.returnData?.galleryItems)!
                self.comicLists = (model.data?.returnData?.comicLists)!
                self.tableView.reloadData()


            }).disposed(by: disposeBag)
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
extension YYQRecommendViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comicLists.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1;
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}




