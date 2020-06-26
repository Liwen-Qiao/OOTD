//
//  ClothesRealmModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/19.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import RealmSwift

class ClothesRealmModel: Object {
    
    @objc dynamic var clothesId: String = UUID().uuidString
    @objc dynamic var clothesType: Int = 0
    @objc dynamic var clothesSubType: Int = 0
    @objc dynamic var clothesMainImage: String = ""
    @objc dynamic var clothesMainImageType: String = ""
    
    override static func primaryKey() -> String? {
        return "clothesId"
    }
    
    static func classifyClothesByType(clothesList: [ClothesRealmModel], clothesType: [Int]) -> [[ClothesRealmModel]] {
        var classifiedArray: [[ClothesRealmModel]]  = []
        
        let clothesTypeCount = clothesType.count
        for _ in 0 ..< clothesTypeCount {
            let oneTypeDataList: [ClothesRealmModel] = []
            classifiedArray.append(oneTypeDataList)
        }
        for clothes in clothesList {
            for (index, clothesOneType) in clothesType.enumerated(){
                if clothes.clothesType == clothesOneType - 1 {
                var oneTypeDataList = classifiedArray[index] //这里要求，type的类型恰巧和分类数组的index正好相同
                oneTypeDataList.append(clothes)
                classifiedArray[index] = oneTypeDataList
            }
            }
        }
        return classifiedArray
    }
}

