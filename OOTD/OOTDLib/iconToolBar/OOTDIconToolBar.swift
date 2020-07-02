//
//  OOTDIconToolBar.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

protocol OOTDIconBarItemSelectedDelegate: class {
    func oneIconBarItemCellPressed(pressedIndex: Int)
}

class OOTDIconToolBar: UICollectionView {
    
    private var toolBarItemList: [OOTDIconToolBarModel] = []
    private weak var clothesIconBarItemSelectDelegate: OOTDIconBarItemSelectedDelegate?
    
    init(frame: CGRect, itemHeight: CGFloat, itemWidth: CGFloat, toolBarItemList: [OOTDIconToolBarModel], delegate: OOTDIconBarItemSelectedDelegate) {
        
        clothesIconBarItemSelectDelegate = delegate
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        super.init(frame: frame, collectionViewLayout: layout)
        register(OOTDIconToolBarCell.self, forCellWithReuseIdentifier: "OOTDIconToolBarCell")
        showsHorizontalScrollIndicator = false
        self.backgroundColor = OOTDConstant.darkBgColor
        self.delegate = self
        self.dataSource = self
        
        self.toolBarItemList.append(contentsOf: toolBarItemList)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedDefault(){
        self.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    func updateBoolBarType(toolBarItemList: [OOTDIconToolBarModel]){
        self.toolBarItemList.removeAll()
        self.toolBarItemList.append(contentsOf: toolBarItemList)
        self.reloadData()
    }
}

extension OOTDIconToolBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toolBarItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDIconToolBarCell", for: indexPath) as! OOTDIconToolBarCell
        cell.updateIconToolBarCell(toolBarItem: toolBarItemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clothesIconBarItemSelectDelegate?.oneIconBarItemCellPressed(pressedIndex: indexPath.row)
    }
    
    
}

