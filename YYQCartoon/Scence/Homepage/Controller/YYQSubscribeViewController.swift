//
//  YYQSubscribeViewController.swift
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

class YYQSubscribeViewController: YYQBaseViewController {

    var disposeBag = DisposeBag()
    var datasource = [Subscribe]()

    lazy var tableView: UITableView = {

        let tableView = UITableView()
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        YYQRequest.getSubscribeList()
            .subscribe(onNext: { (model) in

                self.datasource = (model.data?.returnData?.newSubscribeList)!
                self.tableView.reloadData()

            }).disposed(by: disposeBag)


        // Do any additional setup after loading the view.
    }


    func setUI()  {

        self.tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: CGFloat(ScreenHeight-kNavigationBarHeight-SafeAreaBottomHeight-49))
        
        self.view.addSubview(self.tableView)

        self.tableView.register(UINib.init(nibName: "YYQSubscribeViewCell", bundle: nil), forCellReuseIdentifier: "YYQSubscribeViewCell")
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

extension YYQSubscribeViewController:UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "YYQSubscribeViewCell") as! YYQSubscribeViewCell?
        if  cell == nil  {
            cell = YYQSubscribeViewCell(style: .default, reuseIdentifier: "YYQSubscribeViewCell")
        }
        cell?.setModel(model: self.datasource[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}



