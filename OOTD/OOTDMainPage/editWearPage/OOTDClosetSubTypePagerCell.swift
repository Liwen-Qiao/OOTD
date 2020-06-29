//
//  OOTDClosetSubTypePagerCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClosetSubTypePagerCell: UICollectionViewCell{
    
    private var closetSubTypeToolBar: OOTDTextToolBar!
    private var closetSubTypeCollectionView: UICollectionView!
    
    private var clothes2DList: [[ClothesRealmModel]] = []
    private var toolBarItemList: [OOTDTextToolBarModel] = []
    private weak var clothesItemSelectDelegate: OOTDClothesItemSelectDelegate?
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        closetSubTypeToolBar = OOTDTextToolBar(frame: CGRect.zero,
                                               cellWidth: UIScreen.main.bounds.width/4.5,
                                               cellHeight: 50,
                                               cellTextColor: OOTDConstant.darkBgColor,
                                               cellBgColor: .white,
                                               cellHighlightColor: OOTDConstant.universalColor,
                                               toolBarItemList: [],
                                               delegate: self,
                                               viewTag: "clothesToolBar")
        
        closetSubTypeToolBar.backgroundColor = OOTDConstant.white
        self.addSubview(closetSubTypeToolBar)
        closetSubTypeToolBar.easy.layout([Left(0), Right(0), Height(50), Top(0)])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        closetSubTypeCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        closetSubTypeCollectionView.backgroundColor = OOTDConstant.cloudColor
        closetSubTypeCollectionView.register(OOTDClothesPagerCell.self, forCellWithReuseIdentifier: "OOTDClothesPagerCell")
        closetSubTypeCollectionView.showsHorizontalScrollIndicator = false
        //closetSubTypeCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        closetSubTypeCollectionView.isPagingEnabled = true
        closetSubTypeCollectionView.delegate = self
        closetSubTypeCollectionView.dataSource = self
        self.addSubview(closetSubTypeCollectionView)
        closetSubTypeCollectionView.easy.layout(Left(0), Right(0), Top(0).to(closetSubTypeToolBar), Bottom(20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateclothes2DList(clothesItemList: [[ClothesRealmModel]], delegate: OOTDClothesItemSelectDelegate, toolBarItemList: [OOTDTextToolBarModel]){
        self.clothesItemSelectDelegate = delegate
        self.clothes2DList.removeAll()
        self.clothes2DList.append(contentsOf: clothesItemList)
        closetSubTypeCollectionView.reloadData()
        self.closetSubTypeToolBar.updateToolBarItemList(toolBarItemList: toolBarItemList)
    }
}

extension OOTDClosetSubTypePagerCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)
//    }
}

extension OOTDClosetSubTypePagerCell: OOTDTextBarItemSelectDelegate{
    func oneTextBarItemCellPressed(pressedIndex: Int) {
        let indexPath = IndexPath(row: pressedIndex, section: 0)
        self.closetSubTypeCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
