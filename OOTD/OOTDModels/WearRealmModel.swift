//
//  WearRealmModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/20.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import RealmSwift

class WearRealmModel: Object {
    
    @objc dynamic var wearId: String = UUID().uuidString
    @objc dynamic var wearType: Int = 0
    @objc dynamic var wearSubType: Int = 0
    @objc dynamic var wearMainImage: String = ""
    @objc dynamic var wearMainImageType: String = ""
    
    let wearClothesList = List<WearClothesRealmModel>()
    
    override static func primaryKey() -> String? {
        return "wearId"
    }
    
    
}



