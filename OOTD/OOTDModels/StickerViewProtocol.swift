//
//  StickerViewProtocol.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/20.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

protocol StickerViewProtocol {
    
    var stickerViewId: Int { get set }
   // var stickerViewName: String { get set }
    var stickerViewWidth: Int { get set }
    var stickerViewHeight: Int { get set }
    var stickerViewLocationX: Int { get set }
    var stickerViewLocationY: Int { get set }
    var stickerViewRadian: CGFloat { get set }
    var stickerViewMainImage: String { get set }
    var stickerViewMainImageType: String { get set }
    
}
