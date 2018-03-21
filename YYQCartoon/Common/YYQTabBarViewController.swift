//
//  YYQTabBarViewController.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setMainVC()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setMainVC()  {

        let homeCtr = YYQHomePageViewController()
        addChildViewController(homeCtr, title: "首页", image: UIImage(named: "tab_home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_home_S")?.withRenderingMode(.alwaysOriginal))

        let bookCtr = YYQBookstoreViewController()
        addChildViewController(bookCtr, title: "书架", image: UIImage(named: "tab_book")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_book_S")?.withRenderingMode(.alwaysOriginal))

        let categoryCtr = YYQCategoryViewController()
           addChildViewController(categoryCtr, title: "分类", image: UIImage(named: "tab_class")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_class_S")?.withRenderingMode(.alwaysOriginal))

        let meCtr = YYQMeViewController()
        addChildViewController(meCtr, title: "我的", image: UIImage(named: "tab_mine")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_mine_S")?.withRenderingMode(.alwaysOriginal))


        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false

        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        //添加自定义分割线
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(ScreenWidth), height: 0.5))
        backView.backgroundColor = UIColor.black
        tabBar.insertSubview(backView, at: 0)
        tabBar.isOpaque = true

    }


    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage?, selectedImage:UIImage?) {

        childController.title = nil
        childController.tabBarItem.image = image
        childController.tabBarItem.selectedImage = selectedImage

        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChildViewController(YYQNavigationViewController(rootViewController: childController))
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
