//
//  YYQScrollView.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/23.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import Kingfisher

class YYQScrollView: UIView {

    private var gallerys = [GalleryItem]()

    private var currentImgView:UIImageView?
    private var lastImgView:UIImageView?
    private var nextImgView:UIImageView?
    private var showIndex:Int = 1

    lazy var mainScroll: UIScrollView = {
        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.bounces = false
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        return contentView
    }()

    lazy var pageControl: UIPageControl = {

        let pageCtr = UIPageControl()
        pageCtr.currentPage = 0
        pageCtr.pageIndicatorTintColor = UIColor.lightGray
        pageCtr.currentPageIndicatorTintColor = UIColor.white
        pageCtr.addTarget(self, action: #selector(self.pageControlValueChange), for: .valueChanged)
        return pageCtr
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        mainScroll.frame = frame
        pageControl.frame = CGRect(x: 100, y: frame.size.height-30, width: frame.size.width-200, height: 30)
        addSubview(mainScroll)
        addSubview(pageControl)

        let timer = Timer(timeInterval: 2, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }

    @objc private func handleTimer() {

//        showIndex += 1
//        if showIndex >= 5 {
//            showIndex = 0
//        }
//        let xOffset = Int(self.contentOffset.x/kScreenWidth)
//        let xOffsetFloat = CGFloat(xOffset) * kScreenWidth
//        let newOffset = CGPoint(x: xOffsetFloat + self.frame.width, y: self.contentOffset.y)
//        self.setContentOffset(newOffset, animated: true)
    }

    func setUpScrollView(array:[GalleryItem])  {


        gallerys = array
        if  array.count<0 {
            return
        }
//
        showIndex = 1 // 先显示第一张图片
        pageControl.numberOfPages = array.count
        mainScroll.contentSize = CGSize(width: 3*ScreenWidth, height: 200)
        lastImgView = UIImageView(frame:CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        currentImgView = UIImageView(frame:CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: 200))
        nextImgView = UIImageView(frame:CGRect(x: 2*ScreenWidth, y: 0, width: ScreenWidth, height: 200))
        mainScroll.addSubview(lastImgView!)
        mainScroll.addSubview(currentImgView!)
        mainScroll.addSubview(nextImgView!)
        mainScroll.setContentOffset(CGPoint(x:ScreenWidth,y: 0), animated: false)

        configImageView()

    }

    @objc func pageControlValueChange(pageCtr:UIPageControl) {

//        let index = pageCtr.currentPage
//
//        mainScroll.setContentOffset(CGPoint(x:ScreenWidth*CGFloat(index),y: 0), animated: true)

    }


    /// 切换图片资源  最终修改ContentSize 为ScreenWidth 0
    func configImageView()  {

        let lastIndex:Int
        let nextIndex:Int

        if showIndex-1 < 0 {
            lastIndex = gallerys.count-1
        }else {
            lastIndex = showIndex-1
        }
        if showIndex+1 > gallerys.count-1 {
            nextIndex = 0
        }else {
            nextIndex = showIndex+1
        }

        lastImgView?.kf.setImage(with: ImageResource(downloadURL: URL.init(string: (gallerys[lastIndex].cover!))!),
                                 placeholder: UIImage(named:"normal_placeholder_h"),
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)

        currentImgView?.kf.setImage(with: ImageResource(downloadURL: URL.init(string: (gallerys[showIndex].cover!))!),
                                 placeholder: UIImage(named:"normal_placeholder_h"),
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)

        nextImgView?.kf.setImage(with: ImageResource(downloadURL: URL.init(string: (gallerys[nextIndex].cover!))!),
                                 placeholder: UIImage(named:"normal_placeholder_h"),
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)

        mainScroll.setContentOffset(CGPoint(x:ScreenWidth,y: 0), animated: false)
        self.pageControl.currentPage = lastIndex
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension YYQScrollView : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.x/ScreenWidth
        if offset >= 2 {
            showIndex = self.getArrayIndex(showIndex + 1)
            configImageView()
            
        } else if offset <= 0 {
            showIndex = self.getArrayIndex(showIndex - 1)
            configImageView()
        }
    }

    func getArrayIndex(_ currentIndex: Int) -> Int{
        if currentIndex == -1 {
            return gallerys.count - 1
        } else if currentIndex == gallerys.count {
            return 0
        } else {
            return currentIndex
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }

}

