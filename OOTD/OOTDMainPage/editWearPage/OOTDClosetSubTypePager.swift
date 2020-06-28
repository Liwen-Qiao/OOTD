//
//  OOTDClosetSubTypePager.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClosetSubTypePager: UICollectionViewCell{
    
    private var closetSubTypeToolBar: OOTDTextToolBar!
    private var closetSubTypeCollectionView: UICollectionView!
    
    private var clothes2DList: [[ClothesRealmModel]] = []
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    init(frame: CGRect, cellWidth : CGFloat, cellHeight: CGFloat,toolBarItemList: [OOTDTextToolBarModel],
         clothes2DList: [[ClothesRealmModel]], delegate: OOTDClothesItemSelectDelegate) {

        super.init(frame: frame)
        
        closetSubTypeToolBar = OOTDTextToolBar(frame: CGRect.zero,
                                               cellWidth: 50,
                                               cellHeight: 80,
                                               cellTextColor: OOTDConstant.universalColor,
                                               cellBgColor: .white,
                                               cellHighlightColor: OOTDConstant.darkBgColor,
                                               toolBarItemList: toolBarItemList,
                                          delegate: self,
                                          viewTag: "clothesToolBar")
        
          closetSubTypeToolBar.backgroundColor = OOTDConstant.cloudColor
          self.addSubview(closetSubTypeToolBar)
          closetSubTypeToolBar.easy.layout([Left(0), Right(0), Height(55), Top(0)])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight-1)
        
        closetSubTypeCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        closetSubTypeCollectionView.backgroundColor = OOTDConstant.cloudColor
        closetSubTypeCollectionView.register(OOTDClothesPagerCell.self, forCellWithReuseIdentifier: "OOTDClothesPagerCell")
        closetSubTypeCollectionView.showsHorizontalScrollIndicator = false
        closetSubTypeCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        closetSubTypeCollectionView.isPagingEnabled = true
        closetSubTypeCollectionView.delegate = self
        closetSubTypeCollectionView.dataSource = self
        
        self.clothes2DList.append(contentsOf: clothes2DList)
        self.clothesItemSelectDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateclothes2DList(clothesItemList: [[ClothesRealmModel]]){
        self.clothes2DList = clothesItemList
        closetSubTypeCollectionView.reloadData()
    }
}

extension OOTDClosetSubTypePager: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes2DList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDClothesPagerCell", for: indexPath) as! OOTDClothesPagerCell
        if let degegate = self.clothesItemSelectDelegate{
            cell.updatePagerCell(clothesList: clothes2DList[indexPath.row], delegate: degegate)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
}

extension OOTDClosetSubTypePager: OOTDTextBarItemSelectDelegate{
    func oneTextBarItemCellPressed(pressedIndex: Int, viewTag: String) {
        
    }
}
