//
//  YYQSegmentViewController.swift
//  YYQCartoon
//
//  Created by kongchenliang on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQSegmentViewController: YYQBaseViewController {


    lazy var segmentBar: YYQSegmentBarView = {
        let segmentBar = YYQSegmentBarView()
        return segmentBar
    }()

    lazy var contentView: UIScrollView = {

        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.bounces = false
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        return contentView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
      

        if #available(iOS 11.0, *)  {

            self.contentView.contentInsetAdjustmentBehavior = .never
        }else {

            self.automaticallyAdjustsScrollViewInsets = false
        }
        //默认显示第一个控制器
        segmentBar.delegate = self
        segmentBar.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        segmentBar.backgroundColor = UIColor.clear

        self.navigationItem.titleView = self.segmentBar
        
        // Do any additional setup after loading the view.
    }

   
    /// scroller + ViewController
    ///
    /// - Parameters:
    ///   - childVCtrs: 字控制器
    func setUpWithChildViewController(childVCtrs:Array<UIViewController>)  {
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: CGFloat(ScreenHeight-kNavigationBarHeight-SafeAreaBottomHeight-49))
        self.view.addSubview(self.contentView)
        self.contentView.contentSize = CGSize(width: ScreenWidth*CGFloat(childVCtrs.count), height: ScreenHeight-kNavigationBarHeight-SafeAreaBottomHeight-49)
        
        for vc:UIViewController in childVCtrs {
            self.addChildViewController(vc)
        }

        showChildVCView(index: 0)
    }


    /// 显示当前控制器
    ///
    /// - Parameter index: 第几个控制器
    func showChildVCView(index:Int)  {
        
        if self.childViewControllers.count == 0 {
            return;
        }
        let vcCtr = self.childViewControllers[index]
        vcCtr.view.frame = CGRect(x: ScreenWidth*CGFloat(index), y: 0, width: ScreenWidth, height: self.contentView.frame.size.height)

        self.contentView.addSubview(vcCtr.view)
        self.contentView.setContentOffset(CGPoint(x:ScreenWidth*CGFloat(index),y: 0), animated: true)

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

extension YYQSegmentViewController: UIScrollViewDelegate,YYQSegmentBarSelectedDelegate {


    /// 滚动
    ///
    /// - Parameter scrollView: scrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x/ScreenWidth
        showChildVCView(index: Int(offset))

        segmentBar.selectOneButton(index: Int(offset))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

    }

    func selectBarIndex(index: Int) {

        showChildVCView(index: index)
    }
}



