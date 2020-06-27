//
//  OOTDTextToolBarModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation

struct OOTDTextToolBarModel {

    var toolBarItemName: String
    
    init(toolBarItemDic: [String: Any]) {
        toolBarItemName = toolBarItemDic["toolBarItemName"] as? String ?? ""
    }
    
    static func getClothesSubTypeToolbarTools() -> [OOTDTextToolBarModel] {
        let dicData = [
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"],
            ["toolBarItemName": "Add"]
        ]
        
        let clothesSubTypeToolBarItemList = dicData.map({ oneDic in
            return OOTDTextToolBarModel(toolBarItemDic: oneDic)
        })
        
        return clothesSubTypeToolBarItemList
    }
    
}


