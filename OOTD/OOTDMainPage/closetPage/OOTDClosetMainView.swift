//
//  OOTDClosetMainView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/17.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

protocol OOTDClothesTypeSelectDelegate: class {
    func oneClothesTypePressed(pressedIndex: Int)
}

class OOTDClosetMainView: UICollectionView {
    
    //delegate
    private weak var clothesTypeSelectDelegate: OOTDClothesTypeSelectDelegate?
    
    init(frame: CGRect, delegate: OOTDClothesTypeSelectDelegate) {
        self.clothesTypeSelectDelegate = delegate
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
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
    
    func setSelectedDefault(){
        self.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    func updateBoolBarType(clothesTypeList: [String]){
//        self.toolBarItemList.removeAll()
//        self.toolBarItemList.append(contentsOf: toolBarItemList)
        self.reloadData()
    }
}

extension OOTDClosetMainView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1
        //toolBarItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDClosetMainViewCell", for: indexPath) as! OOTDClosetMainViewCell
//        //cell.updateIconToolBarCell(toolBarItem: toolBarItemList[indexPath.row],
//                                   highlightColor: highlightColor,
//                                   backgroundColor : backGroundColor,
//                                   iconHeight: iconHeight)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clothesTypeSelectDelegate?.oneClothesTypePressed(pressedIndex: indexPath.row)
    }
}

