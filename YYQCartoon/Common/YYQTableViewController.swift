//
//  YYQTableViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/26.
//  Copyright © 2018年 KCL. All rights reserved.
//

//MARK: 用泛型封装TableViewController
import Foundation
import UIKit

protocol Configurable {

//    associatedtype ItemType:Any
    func config(item:Any)
}

class TableViewController<T, Cell:UITableViewCell>:UITableViewController where Cell:Configurable {

    let cellIdentifier = String(describing: Cell())

    // 无论数据什么时候更新，都会reloadData()

    var data = [T]() {

        didSet {

            tableView.reloadData()
            if tableView.numberOfRows(inSection: 0)>0 {
                tableView.scrollToRow(at: NSIndexPath(row: 0,section: 0) as IndexPath,
                                      at: .top,
                                      animated: true)
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

    }

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell

        cell.config(item: data[indexPath.row])

        return cell
    }
}
