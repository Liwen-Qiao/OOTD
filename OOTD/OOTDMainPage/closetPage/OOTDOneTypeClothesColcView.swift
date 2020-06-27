//
//  OOTDOneTypeClothesColcView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/17.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

protocol OOTDClothesSelectDelegate: class {
    func oneClothesPressed(pressedIndex: Int)
}

class OOTDOneTypeClothesColcView: UICollectionView {
    
    private var oneTypeClothesList: [ClothesRealmModel] = []
    //delegate
    private weak var clothesTypeSelectDelegate: OOTDClothesSelectDelegate?
    
    init(frame: CGRect, oneTypeClothesList: [ClothesRealmModel]) {
        //self.clothesTypeSelectDelegate = delegate
        
        self.oneTypeClothesList.append(contentsOf: oneTypeClothesList)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 25)/3, height: (UIScreen.main.bounds.width - 25)/2.5)
        
        super.init(frame: frame, collectionViewLayout: layout)
        register(OOTDClosetMainViewCell.self, forCellWithReuseIdentifier: "OOTDClosetMainViewCell")
        showsHorizontalScrollIndicator = false
        self.backgroundColor = backgroundColor
        self.delegate = self
        self.dataSource = self
        
        //self.toolBarItemList.append(contentsOf: toolBarItemList)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setSelectedDefault(){
//        self.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
//    }
//
//    func updateToolBarType(clothesTypeList: [String]){
//        //        self.toolBarItemList.removeAll()
//        //        self.toolBarItemList.append(contentsOf: toolBarItemList)
//        self.reloadData()
//    }
}

extension OOTDOneTypeClothesColcView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  oneTypeClothesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDClosetMainViewCell", for: indexPath) as! OOTDClosetMainViewCell
        cell.updateClosetTypeViewCell(clotherModel: self.oneTypeClothesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //clothesTypeSelectDelegate?.oneClothesTypePressed(pressedIndex: indexPath.row)
    }
}

