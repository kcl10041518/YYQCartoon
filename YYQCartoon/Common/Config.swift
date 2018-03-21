//
//  Config.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

// IphoneX 适配
let kNavigationBarHeight =  ScreenHeight == 812.0 ? 88 : 64
let SafeAreaBottomHeight =  ScreenHeight == 812.0 ? 34 : 0
