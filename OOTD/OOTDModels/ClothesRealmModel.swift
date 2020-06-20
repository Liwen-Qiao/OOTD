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
}

