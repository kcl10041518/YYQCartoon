//
//  YYQBaseViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/22.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        if #available(iOS 11.0, *) {

        }else {

            self.automaticallyAdjustsScrollViewInsets = false
        }

        setNavigationIsTranslucent(isTranslucent: false)

        // Do any additional setup after loading the view.
    }

    func setRightItemImage(image:UIImage?, selectedImage:UIImage?, target:Any, selector:Selector)  {

        let leftBarButton = UIBarButtonItem(image: image, style: .done, target: self, action: selector)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }

    func setNavigationIsTranslucent(isTranslucent:Bool) {

        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        if isTranslucent == true {

            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.shadowImage = UIImage()

        }else {

            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"nav_bg"), for: .default)
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
