//
//  Config.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height

// IphoneX 适配
let kNavigationBarHeight:CGFloat =  ScreenHeight == 812.0 ? 88 : 64
let SafeAreaBottomHeight:CGFloat =  ScreenHeight == 812.0 ? 34 : 0

//let AppMainColor = UIcolor
//  Converted to Swift 4 by Swiftify v4.1.6654 - https://objectivec2swift.com/
func UIColorRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> Any {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func UIColorRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> Any {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}
func UIColorFromRGB(rgbValue: Int) -> Any {
    return UIColor(red: CGFloat((Float((rgbValue & 0xff0000) >> 16) / 255.0)), green: CGFloat((Float((rgbValue & 0x00ff00) >> 8) / 255.0)), blue: CGFloat((Float(rgbValue & 0x0000ff) / 255.0)), alpha: 1.0)
}


