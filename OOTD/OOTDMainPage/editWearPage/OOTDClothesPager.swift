//
//  OOTDClothesPager.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClothesPager: UICollectionView {
    
    private var clothes2DList: [[ClothesRealmModel]] = []
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    init(frame: CGRect, cellWidth : CGFloat, cellHeight: CGFloat,
         clothes2DList: [[ClothesRealmModel]], delegate: OOTDClothesItemSelectDelegate) {

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight-1)
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = OOTDConstant.cloudColor
        self.register(OOTDClothesPagerCell.self, forCellWithReuseIdentifier: "OOTDClothesPagerCell")
        self.showsHorizontalScrollIndicator = false
        self.automaticallyAdjustsScrollIndicatorInsets = false
        self.isPagingEnabled = true
        self.delegate = self
        self.dataSource = self
        
        self.clothes2DList.append(contentsOf: clothes2DList)
        self.clothesItemSelectDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateclothes2DList(clothes2DList: [[ClothesRealmModel]]){
        self.clothes2DList = clothes2DList
        self.reloadData()
    }
}

extension OOTDClothesPager: UICollectionViewDataSource, UICollectionViewDelegate{
    
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

