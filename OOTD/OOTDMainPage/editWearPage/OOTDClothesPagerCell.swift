//
//  OOTDClothesPagerCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy


protocol OOTDClothesItemSelectDelegate : class {
    func oneClothesItemPressed(clothesInfo: ClothesRealmModel)
    func addButtonPressed()
}

class OOTDClothesPagerCell: UICollectionViewCell {
    
    private var clothesCollectionView: UICollectionView!
    
    private var clothes1DList: [ClothesRealmModel] = []
    private var viewTag: String = ""
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height:50)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        clothesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        clothesCollectionView.register(OOTDClothesGridCell.self, forCellWithReuseIdentifier: "OOTDClothesGridCell")
        clothesCollectionView.backgroundColor = OOTDConstant.cloudColor
        clothesCollectionView.delegate = self
        clothesCollectionView.dataSource = self
        
        addSubview(clothesCollectionView)
        clothesCollectionView.easy.layout(Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePagerCell(clothesList: [ClothesRealmModel], delegate: OOTDClothesItemSelectDelegate ){
        self.clothesItemSelectDelegate = delegate
        self.clothes1DList.removeAll()
        self.clothes1DList.append(contentsOf: clothesList)
        clothesCollectionView.reloadData()
    }    
}

extension OOTDClothesPagerCell: UICollectionViewDataSource, UICollectionViewDelegate{ 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes1DList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDClothesGridCell", for: indexPath) as! OOTDClothesGridCell
        if indexPath.row == 0{
            cell.createdAddButton()
        }else if indexPath.row != 0{
            cell.updateGridCell(clothesModel: clothes1DList[indexPath.row - 1])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            clothesItemSelectDelegate?.addButtonPressed()
        }else {
            clothesItemSelectDelegate?.oneClothesItemPressed(clothesInfo: clothes1DList[indexPath.row - 1])
        }
    }
}


