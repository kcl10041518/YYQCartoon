//
//  YYQHomePageViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQHomePageViewController: UIViewController {
    
    
    lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segCtr = YYQSegmentViewController()
        let vipListCtr = YYQVipListViewController()
        let rankListCtr = YYQRankListViewController()
        let recmdCtr = YYQRecommendViewController()
        let subCtr = YYQSubscribeViewController()
        let items = ["推荐","VIP","订阅","排行"]
        let childCtrs = [ recmdCtr, vipListCtr, subCtr,rankListCtr]
        
        segCtr.setUpWithItems(items: items, childVCtrs: childCtrs)
        self.addChildViewController(segCtr)
        self.view.addSubview(segCtr.view)

//        self.view.backgroundColor = UIColor.white
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
