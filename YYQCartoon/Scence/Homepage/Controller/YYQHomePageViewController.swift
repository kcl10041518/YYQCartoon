//
//  YYQHomePageViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQHomePageViewController: YYQSegmentViewController {
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = ["推荐","VIP","订阅","排行"]
        let childCtrs = [ YYQRecommendViewController(),
                          YYQVipListViewController(),
                          YYQSubscribeViewController(),
                          YYQRankListViewController()]
        setUpWithChildViewController(childVCtrs: childCtrs)
        segmentBar.setUpItems(items: items)

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
