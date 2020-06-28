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
       
    //delegate
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    init(frame: CGRect, toolBarItemList: [OOTDIconToolBarModel], clothesItemList: [[[ClothesRealmModel]]],
         delegate: OOTDClothesItemSelectDelegate, clothesPagerCellHeight: CGFloat){
        
        super.init(frame: frame)
        self.backgroundColor = OOTDConstant.cloudColor
        
        //self.toolBarItemList = toolBarItemList
        self.clothesItemList = clothesItemList
        self.clothesItemSelectDelegate = delegate
        
       clothesToolBar = OOTDIconToolBar(frame: CGRect.zero,
                                        itemHeight: 50,
                                        itemWidth: 80,
                                        iconHeight: 25,
                                        backgroundColor: OOTDConstant.universalColor,
                                        toolBarItemList: toolBarItemList,
                                        highlightColor: OOTDConstant.darkBgColor,
                                        delegate: self,
                                        viewTag: "clothesToolBar")
      
        clothesToolBar.backgroundColor = OOTDConstant.cloudColor
        self.addSubview(clothesToolBar)
        clothesToolBar.easy.layout([Left(0), Right(0), Height(55), Top(0)])
        

        
//        closetTypePager = OOTDClosetTypePager()
////        //(frame: CGRect.zero, cellWidth : UIScreen.main.bounds.width,
////                                        cellHeight: clothesPagerCellHeight,
////                                        clothes2DList: self.clothesItemList, delegate: delegate)
//        self.addSubview(closetTypePager)
//        closetTypePager.easy.layout([Left(0), Right(0), Top(0).to(clothesToolBar), Bottom(0)])
//        closetTypePager.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTileclothesData(clothesItemList: [[[ClothesRealmModel]]]){
        //self.closetTypePager.updateclothes2DList(clothes2DList: clothesItemList)
    }
}

extension OOTDClosetView: OOTDIconBarItemSelectedDelegate {
    func oneIconBarItemCellPressed(pressedIndex: Int, viewTag: String) {
        let indexPath = IndexPath(row: pressedIndex, section: 0)
        self.closetTypePager.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
