//
//  OOTDClosetView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/27.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy


class OOTDClosetView: UIView {
    
    //view
    private var clothesToolBar: OOTDIconToolBar!
    private var closetTypePager: OOTDClosetTypePager!
    
    //data
    // private var toolBarItemList: [OOTDIconToolBarModel] = []
    private var clothesItemList: [[[ClothesRealmModel]]] = []
    
    init(frame: CGRect, toolBarItemList: [OOTDIconToolBarModel], clothesItemList: [[[ClothesRealmModel]]], textToolBarItemList: [[OOTDTextToolBarModel]],
         delegate: OOTDClothesItemSelectDelegate){
        
        super.init(frame: frame)
        self.backgroundColor = OOTDConstant.cloudColor
        
        //self.toolBarItemList = toolBarItemList
        self.clothesItemList = clothesItemList
        
        clothesToolBar = OOTDIconToolBar(frame: CGRect.zero,
                                         itemHeight: 53,
                                         itemWidth: UIScreen.main.bounds.width/4,
                                         iconHeight: 25,
                                         backgroundColor: OOTDConstant.universalColor,
                                         toolBarItemList: toolBarItemList,
                                         highlightColor: OOTDConstant.darkBgColor,
                                         delegate: self,
                                         viewTag: "clothesToolBar")
        
        clothesToolBar.backgroundColor = OOTDConstant.white
        clothesToolBar.layer.borderWidth = 2
        clothesToolBar.layer.borderColor = OOTDConstant.darkBgColor.cgColor
        clothesToolBar.setSelectedDefault()
        self.addSubview(clothesToolBar)
        clothesToolBar.easy.layout([Left(0), Right(0), Height(55), Top(0)])
        
        closetTypePager = OOTDClosetTypePager(frame: CGRect.zero,
                                              toolBarItemList: textToolBarItemList,
                                              clothesItemList: clothesItemList,
                                              delegate: delegate)
        self.addSubview(closetTypePager)
        closetTypePager.easy.layout([Left(0), Right(0), Top(0).to(clothesToolBar), Bottom(0)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTileclothesData(clothesItemList: [[[ClothesRealmModel]]]){
        self.closetTypePager.updatecClothes3DList(clothes3DList: clothesItemList)
    }
}

extension OOTDClosetView: OOTDIconBarItemSelectedDelegate {
    func oneIconBarItemCellPressed(pressedIndex: Int) {
        let indexPath = IndexPath(row: pressedIndex, section: 0)
        self.closetTypePager.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
