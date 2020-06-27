//
//  OOTDIconToolBar.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

protocol OOTDIconBarItemSelectedDelegate: class {
    func oneIconBarItemCellPressed(pressedIndex: Int, viewTag: String)
}

class OOTDIconToolBar: UICollectionView {
    
    //data
    private var iconToolBarViewTag: String
    private var iconHeight: CGFloat
    private var highlightColor: UIColor?
    private var backGroundColor: UIColor
    private var toolBarItemList: [OOTDIconToolBarModel] = []
    //delegate
    private weak var clothesIconBarItemSelectDelegate: OOTDIconBarItemSelectedDelegate?
    
    init(frame: CGRect, itemHeight: CGFloat, itemWidth: CGFloat, iconHeight: CGFloat, backgroundColor: UIColor, toolBarItemList: [OOTDIconToolBarModel], highlightColor: UIColor?, delegate: OOTDIconBarItemSelectedDelegate, viewTag: String) {
        
        iconToolBarViewTag = viewTag
        self.highlightColor = highlightColor
        clothesIconBarItemSelectDelegate = delegate
        self.backGroundColor = backgroundColor
        self.iconHeight = iconHeight
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        super.init(frame: frame, collectionViewLayout: layout)
        register(OOTDIconToolBarCell.self, forCellWithReuseIdentifier: "OOTDIconToolBarCell")
        showsHorizontalScrollIndicator = false
        self.backgroundColor = backgroundColor
        self.delegate = self
        self.dataSource = self
        
        self.toolBarItemList.append(contentsOf: toolBarItemList)
        
        //self.backgroundView = UIImageView(image: #imageLiteral(resourceName: "iconToolBarBg"))
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
        cell.updateIconToolBarCell(toolBarItem: toolBarItemList[indexPath.row],
                                   highlightColor: highlightColor,
                                   backgroundColor : backGroundColor,
                                   iconHeight: iconHeight)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let toolbarImageUrl = toolBarItemList[indexPath.row].toolBarItemLocalImage
        clothesIconBarItemSelectDelegate?.oneIconBarItemCellPressed(pressedIndex: indexPath.row, viewTag: iconToolBarViewTag)
        
        //print("\(toolBarType)的\(indexPath)")
    }
}

