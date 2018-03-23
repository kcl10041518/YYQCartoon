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

    lazy var tableHeadView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var tableView: UITableView = {

        let tableView = UITableView()
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    lazy var mainScroll: UIScrollView = {
        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.bounces = false
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        return contentView
    }()

    lazy var pageControl: UIPageControl = {

        let pageCtr = UIPageControl()
        pageCtr.currentPage = 0
        pageCtr.pageIndicatorTintColor = UIColor.lightGray
        pageCtr.currentPageIndicatorTintColor = UIColor.white
        return pageCtr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setUI()
        getNetworkData()


        // Do any additional setup after loading the view.
    }
    func setUI() {

        self.tableHeadView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
        self.view.addSubview(self.tableHeadView)
        self.mainScroll.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
        self.tableHeadView.addSubview(self.mainScroll)
        self.tableHeadView.addSubview(self.pageControl)
        self.pageControl.frame = CGRect(x: 100, y: 170, width: ScreenWidth-200, height: 30)
        self.tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-kNavigationBarHeight-49)
        self.tableView.tableHeaderView = self.tableHeadView
        self.view.addSubview(self.tableView)

    }
    func getNetworkData() {

        YYQRequest.getRecommendList()
            .subscribe(onNext: { (model) in

                self.gallerys = (model.data?.returnData?.galleryItems)!
                self.comicLists = (model.data?.returnData?.comicLists)!
                self.setUpScrollView()
                self.tableView.reloadData()

            }).disposed(by: disposeBag)
    }

    func setUpScrollView()  {

        if  self.gallerys.count<0 {
            return
        }
        self.pageControl.numberOfPages = self.gallerys.count
        self.mainScroll.contentSize = CGSize(width: CGFloat(self.gallerys.count)*ScreenWidth, height: 200)
        for i in 0..<self.gallerys.count {

            let model = self.gallerys[i]
            let imgView = UIImageView(frame: CGRect(x: CGFloat(i)*ScreenWidth, y: 0, width: ScreenWidth, height: 200))
            self.mainScroll.addSubview(imgView)
            imgView.contentMode = .center
            imgView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.cover!)!),
                                           placeholder: UIImage(named:"normal_placeholder_h"),
                                           options: nil,
                                           progressBlock: nil,
                                           completionHandler: nil)
        }

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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

extension YYQRecommendViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.x/ScreenWidth
        self.pageControl.currentPage = Int(offset)
    }

}


