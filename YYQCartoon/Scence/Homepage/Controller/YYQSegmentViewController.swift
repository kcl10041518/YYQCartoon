//
//  YYQSegmentViewController.swift
//  YYQCartoon
//
//  Created by kongchenliang on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit

class YYQSegmentViewController: UIViewController {

    lazy var items: NSMutableArray = {
        let items = NSMutableArray()
        return items
    }()
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = true
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //默认显示第一个控制器
       
        
        // Do any additional setup after loading the view.
    }

    public func setUpWithItems(items:Array<Any>, childVCtrs:Array<UIViewController>)  {
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: CGFloat(ScreenHeight))
        self.view.addSubview(self.contentView)
        self.contentView.contentSize = CGSize(width: ScreenWidth*CGFloat(items.count), height: ScreenHeight)
        
        for vc:UIViewController in childVCtrs {
            self.addChildViewController(vc)
//            self.contentView.addSubview(vc.view)
        }
         showChildVCView(index: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showChildVCView(index:Int)  {
        
        if self.childViewControllers.count == 0 {
            return;
        }
        let vcCtr = self.childViewControllers[index]
        vcCtr.view.frame = CGRect(x: ScreenWidth*CGFloat(index), y: 0, width: ScreenWidth, height: ScreenHeight)

        self.contentView.addSubview(vcCtr.view)
        self.contentView.setContentOffset(CGPoint(x:ScreenWidth*CGFloat(index),y: 0), animated: true)

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

extension YYQSegmentViewController: UIScrollViewDelegate {
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x/ScreenWidth
        showChildVCView(index: Int(offset))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x/ScreenWidth
    }
}



