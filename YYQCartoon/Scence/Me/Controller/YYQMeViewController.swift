//
//  YYQMeViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
//,
class YYQMeViewController: TableViewController<Any, YYQMeTableViewCell> {

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
//        setNavigationIsTranslucent(isTranslucent: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.data = ["1","1","1","1","1","1","1","1"];
        
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
