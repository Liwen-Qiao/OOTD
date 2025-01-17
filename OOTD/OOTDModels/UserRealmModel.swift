//
//  UserRealmModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import RealmSwift

class UserRealmModel: Object {
    
    @objc dynamic var userId: String = UUID().uuidString
    @objc dynamic var userEmail: String = ""
    @objc dynamic var userPw: String = ""
    @objc dynamic var userPhoneNumber: Int = 0
    @objc dynamic var userIconImage: String = ""
    @objc dynamic var userIconImageType: String = ""
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}
