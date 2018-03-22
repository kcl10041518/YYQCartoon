//
//  YYQSegmentBarView.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/22.
//  Copyright © 2018年 KCL. All rights reserved.
//

import UIKit
import SnapKit
@objc protocol YYQSegmentBarSelectedDelegate {

    @objc optional func selectBarIndex(index:Int)
}

class YYQSegmentBarView: UIView {


    var delegate:YYQSegmentBarSelectedDelegate?
    lazy var items: [String] = {
        let items = NSMutableArray()
        return items as! [String]
    }()
   
    override init(frame: CGRect) {

        super.init(frame: frame)


//        setUI()
    }
    func setUpItems(items:[String])  {

        let width = self.frame.size.width
        let margin = Int(width)/items.count

        for i in 0..<items.count {

            let button = UIButton(type: .custom)
            button.setTitle(items[i], for: .normal)
            button.addTarget(self, action: #selector(buttonClick(btn:)), for: .touchUpInside)
            button.setTitleColor(UIColor.lightText, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.backgroundColor = UIColor.clear
            self.addSubview(button)
            button.tag = 1000+i
            button.frame = CGRect(x: i*margin, y: 0, width: margin, height: 40)
        }

        selectOneButton(index: 0)

    }
    func selectOneButton(index:Int)  {

        for i in 0..<self.subviews.count{
            let btn = self.viewWithTag(i+1000) as? UIButton
            btn?.isSelected = false
        }
        let btn = self.viewWithTag(index+1000) as! UIButton

        if !btn.isSelected {
            btn.isSelected = true
        }

    }

    @objc func buttonClick(btn:UIButton)  {


        for i in 0..<self.subviews.count{
            let btn = self.viewWithTag(i+1000) as? UIButton
            btn?.isSelected = false
        }

        if !btn.isSelected {
            btn.isSelected = true
        }

        self.delegate?.selectBarIndex!(index: btn.tag-1000)
    }

    override func layoutSubviews() {
        super.layoutSubviews()


    }
//    func setUI()  {
//
//        for str:String in items {
//            print("items = \(str)")
//        }
//    }

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
