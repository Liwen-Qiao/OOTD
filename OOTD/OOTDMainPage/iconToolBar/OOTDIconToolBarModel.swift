//
//  OOTDIconToolBarModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation

struct OOTDIconToolBarModel {
    
    var toolBarItemLocalImage: String
    
    init(toolBarItemDic: [String: Any]) {
        toolBarItemLocalImage = toolBarItemDic["toolBarItemLocalImage"] as? String ?? ""
    }
    
    static func getClothesTypeToolbarTools() -> [OOTDIconToolBarModel] {
        let dicData = [
            ["toolBarItemLocalImage": "noTypeIcon"],
            ["toolBarItemLocalImage": "wearIcon"],
            ["toolBarItemLocalImage": "pantsIcon"],
            ["toolBarItemLocalImage": "handbagsIcon"],
            ["toolBarItemLocalImage": "dressIcon"],
            ["toolBarItemLocalImage": "shoesIcon"],
            ["toolBarItemLocalImage": "accessoriesIcon"]
        ]
        let clothesToolBarItemList = dicData.map({ oneDic in
            return OOTDIconToolBarModel(toolBarItemDic: oneDic)
        })
        
        return clothesToolBarItemList
    }
    
}
