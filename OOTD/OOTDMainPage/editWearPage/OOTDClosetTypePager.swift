//
//  OOTDClosetTypePager.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/28.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy


class OOTDClosetTypePager: UICollectionView {
    
    //data
    private var clothesItemList: [[[ClothesRealmModel]]] = []
       
    //delegate
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    init(frame: CGRect, toolBarItemList: [OOTDTextToolBarModel], clothesItemList: [[[ClothesRealmModel]]],
         delegate: OOTDClothesItemSelectDelegate, clothesPagerCellHeight: CGFloat){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = OOTDConstant.cloudColor
        self.register(OOTDClosetSubTypePager.self, forCellWithReuseIdentifier: "OOTDClosetSubTypePager")
        self.showsHorizontalScrollIndicator = false
        self.automaticallyAdjustsScrollIndicatorInsets = false
        self.isPagingEnabled = true
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateclothes3DList(clothes3DList: [[[ClothesRealmModel]]]){
         self.clothesItemList = clothes3DList
         self.reloadData()
     }
}

//extension OOTDClosetTypePager: OOTDIconBarItemSelectedDelegate {
//    func oneIconBarItemCellPressed(pressedIndex: Int, viewTag: String) {
//        let indexPath = IndexPath(row: pressedIndex, section: 0)
//
//        self.clothesPager.scrollToItem(at: indexPath, at: .left, animated: true)
//    }
//}

extension OOTDClosetTypePager: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDClosetSubTypePager", for: indexPath) as! OOTDClosetSubTypePager
        if let degegate = self.clothesItemSelectDelegate{ //toLearn:
            cell.updateclothes2DList(clothesItemList: clothesItemList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
}

