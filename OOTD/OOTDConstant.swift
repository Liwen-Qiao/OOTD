//
//  OOTDConstant.swift
//  Toodo
//
//  Created by qiaoliwen on 2020/3/4.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation
import UIKit

struct OOTDConstant {
    
    //color
    static let universalColor = #colorLiteral(red: 0.8658104539, green: 0.7707558274, blue: 0.6890796423, alpha: 1)
    static let darkUniversalColor = #colorLiteral(red: 0.5944324136, green: 0.5641926527, blue: 0.5408225656, alpha: 1)
        //UIColor(red: 185/225, green: 185/255, blue: 156/255, alpha: 1.0)
    static let darkBgColor = UIColor(red: 45/225, green: 38/255, blue: 33/255, alpha: 1.0)
    
    static let choosedColor = UIColor(red: 200/255, green: 255/255, blue: 166/255, alpha: 1.0)
    static let cloudColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
    static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    static let customColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 100)
    
    //fontSize
    static let fontTitle = UIFont.systemFont(ofSize: 17)
    static let fontNormal = UIFont.systemFont(ofSize: 14)
    static let fontFrameList = UIFont.systemFont(ofSize: 9)
    static let fontFrame = UIFont.systemFont(ofSize: 9)
    static let fontSmall = UIFont.systemFont(ofSize: 12)
    
    static func getTimeString() -> String{
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "YYYYMMddHHmmss"

        let time = dateformatter.string(from: Date())

        return time
    }
    
}
