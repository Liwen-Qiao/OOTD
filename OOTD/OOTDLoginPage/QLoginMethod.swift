//
//  QLoginMethod.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation
import RealmSwift

protocol QLoginMethod : class{
    func successLogin(page: QMainTabView)
}
extension QLoginMethod{
    func login(email: String, pw: String){
        let realm = try! Realm()
        let predicate = NSPredicate(format: "userEmail = %@", email)
        let theUser = realm.objects(UserRealmModel.self).filter(predicate).first
        if let theRightUser = theUser{
            if theRightUser.userPw == pw{
                let defaults = UserDefaults.standard
                defaults.set(email, forKey: "UserEmail")
                defaults.set(pw, forKey: "Password")
                let page = QMainTabView(UserRealmModel: theRightUser)
                self.successLogin(page: page)
            }else{
                print("密码错误")
            }
        }else{
            print("邮箱未注册")
        }
    }
}
