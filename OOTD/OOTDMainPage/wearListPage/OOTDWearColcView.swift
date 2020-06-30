//
//  OOTDWearColcView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy


class OOTDWearColcView: UICollectionView {
    
    private var wearList: [WearRealmModel] = []
    //delegate
    private weak var clothesTypeSelectDelegate: OOTDClothesSelectDelegate?
    
    init(frame: CGRect, wearList: [WearRealmModel], delegate: OOTDClothesSelectDelegate ) {
        
        self.wearList.append(contentsOf: wearList)
        self.clothesTypeSelectDelegate = delegate
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 25)/3, height: (UIScreen.main.bounds.width - 25)/2.5)
        
        super.init(frame: frame, collectionViewLayout: layout)
        register(OOTDWearColcViewCell.self, forCellWithReuseIdentifier: "OOTDWearColcViewCell")
        showsHorizontalScrollIndicator = false
        self.backgroundColor = backgroundColor
        self.delegate = self
        self.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWearList(wearList: [WearRealmModel]){
        self.wearList.removeAll()
        self.wearList.append(contentsOf: wearList)
        print(wearList.count)
        self.reloadData()
    }
}

extension OOTDWearColcView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  wearList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDWearColcViewCell", for: indexPath) as! OOTDWearColcViewCell
        cell.updateWearColcViewCell(wearModel: self.wearList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.clothesTypeSelectDelegate?.oneClothesPressed(pressedIndex: indexPath.row)
    }
}

