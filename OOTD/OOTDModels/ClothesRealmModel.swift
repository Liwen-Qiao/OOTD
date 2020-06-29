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
                if clothes.clothesType == clothesOneType{
                    var oneTypeDataList = classifiedArray[index]
                    oneTypeDataList.append(clothes)
                    classifiedArray[index] = oneTypeDataList
                }
            }
        }
        return classifiedArray
    }
    
    static func classifyClothesByType(clothesList: [ClothesRealmModel]) -> [[[ClothesRealmModel]]] {
        
        let clothesType = [[0,1],[0,1,2,3,4,5],[0,1,2,3,4],[0,1,2,3,4,5],[0,1,2,3,4,5,6],[0,1,2,3,4],[0,1,2,3,4,5]]
        var classified3DArray: [[[ClothesRealmModel]]]  = []
        
        let clothesTypeCount = clothesType.count
        
        for int in 0 ..< clothesTypeCount {
            var oneTypeDataList: [[ClothesRealmModel]] = []
            for _ in clothesType[int]{
                let oneSubTypeDataList: [ClothesRealmModel] = []
                oneTypeDataList.append(oneSubTypeDataList)
            }
            classified3DArray.append(oneTypeDataList)
        }
        for clothes in clothesList {
            for (index, clothesOneType) in clothesType.enumerated(){
                if clothes.clothesType == index{
                    for (subIndex, clothesOneSubType) in clothesOneType.enumerated(){
                        if clothes.clothesSubType == clothesOneSubType{
                            var oneTypeDataList = classified3DArray[index][subIndex]
                            oneTypeDataList.append(clothes)
                            classified3DArray[index][subIndex] = oneTypeDataList
                        }
                    }
                }
            }
        }
        return classified3DArray
    }
}

