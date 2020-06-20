//
//  WearClothesRealmModel.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/20.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import RealmSwift

class WearClothesRealmModel: Object , StickerViewProtocol{
    
    @objc dynamic var wearClothesId: Int = UUID().hashValue
    @objc dynamic var wearClothesWidth: Int = 100
    @objc dynamic var wearClothesHeight: Int = 100
    @objc dynamic var wearClothesX: Int = 100
    @objc dynamic var wearClothesY: Int = 100
    @objc dynamic var wearClothesScale: CGFloat = 0
    @objc dynamic var wearClothesRadian: CGFloat = 0
    @objc dynamic var wearClothesMainImage: String = ""
    @objc dynamic var wearClothesMainImageType: String = ""
    
    
    override static func primaryKey() -> String? {
        return "wearClothesId"
    }
    
    var stickerViewId: Int{
        get{
            return self.wearClothesId
        }
        set{
            self.wearClothesId = newValue
        }
    }
    
    var stickerViewLocationX: Int{
        get{
            return self.wearClothesX
        }
        set{
            self.wearClothesX = newValue
        }
    }
    
    var stickerViewLocationY: Int{
        get{
            return self.wearClothesY
        }
        set{
            self.wearClothesY = newValue
        }
    }
    var stickerViewRadian: CGFloat{
        get{
            return self.wearClothesRadian
        }
        set{
            self.wearClothesRadian = newValue
        }
    }
    
    var stickerViewWidth: Int{
        get{
            return wearClothesWidth
        }
        set{
            self.wearClothesWidth = newValue
        }
    }
    
    var stickerViewHeight: Int{
        get{
            return wearClothesHeight
        }
        set{
            self.wearClothesHeight = newValue
        }
    }
    
    var stickerViewMainImage: String {
        get{
            return self.wearClothesMainImage
        }
        set{
            self.wearClothesMainImage = newValue
        }
    }
    
    var stickerViewMainImageType: String {
        get{
            return self.wearClothesMainImageType
        }
        set{
            self.wearClothesMainImageType = newValue
        }
    }
}
