//
//  YYQUIViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/27.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import UIKit


class YYQUITableViewController<T,Cell:UITableViewCell>: YYQBaseViewController,UITableViewDelegate,UITableViewDataSource where Cell:Configurable  {

    let cellIdentifier = String(describing: Cell())
    lazy var tableView: UITableView = {

        let tab = UITableView()
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView.init()
        tab.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        return tab
    }()

    var data = [T]()  {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        cell.config(item: data[indexPath.row])

        return cell
    }
}


