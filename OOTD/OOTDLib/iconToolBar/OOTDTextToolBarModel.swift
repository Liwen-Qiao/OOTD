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
    
    static func getClothesSubTypeToolbarTools() -> [[OOTDTextToolBarModel]] {
        let dic2DData : [[[String: Any]]] = [
            [
                ["toolBarItemName": "No type"]
            ],
            [
                ["toolBarItemName": "T-shirt"],
                ["toolBarItemName": "Shirt"],
                ["toolBarItemName": "Tank"],
                ["toolBarItemName": "Sweaters"],
                ["toolBarItemName": "Coats"]
            ],
            [
                ["toolBarItemName": "Pants"],
                ["toolBarItemName": "Leggings"],
                ["toolBarItemName": "Shorts"],
                ["toolBarItemName": "Skirts"],
            ],
            [
                ["toolBarItemName": "Minidress"],
                ["toolBarItemName": "Midi Dress"],
                ["toolBarItemName": "Long"],
                ["toolBarItemName": "Cocktail"],
                ["toolBarItemName": "Gown"]
            ],
            [
                ["toolBarItemName": "Backpacks"],
                ["toolBarItemName": "CrossbodyBags"],
                ["toolBarItemName": "ShoulderBags"],
                ["toolBarItemName": "Totes"],
                ["toolBarItemName": "BeltBags"],
                ["toolBarItemName": "Wallets"]
            ],
            [
                ["toolBarItemName": "Boots"],
                ["toolBarItemName": "Flats"],
                ["toolBarItemName": "Sneakers"],
                ["toolBarItemName": "Heels"]
            ],
            [
                ["toolBarItemName": "Belts"],
                ["toolBarItemName": "Hats"],
                ["toolBarItemName": "Sunglasses"],
                ["toolBarItemName": "Jewellery"],
                ["toolBarItemName": "Watches"]
            ],
        ]
        var clothesSubType2DModel :[[OOTDTextToolBarModel]] = []
        for clothesSubType2DList in dic2DData{
            
            var clothesSubType1DModel :[OOTDTextToolBarModel] = []
            for oneDic in clothesSubType2DList{
                let oneModel = OOTDTextToolBarModel(toolBarItemDic: oneDic)
                clothesSubType1DModel.append(oneModel)
            }
            clothesSubType2DModel.append(clothesSubType1DModel)
        }
        
        return clothesSubType2DModel
    }
    
}


