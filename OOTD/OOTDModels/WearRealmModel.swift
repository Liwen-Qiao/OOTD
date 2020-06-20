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
    @objc dynamic var clothesType: Int = 0
    @objc dynamic var clothesSubType: Int = 0
    @objc dynamic var clothesMainImage: String = ""
    @objc dynamic var clothesMainImageType: String = ""
    
    override static func primaryKey() -> String? {
        return "wearId"
    }
}



