//
//  OOTDTextToolBar.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

protocol OOTDTextBarItemSelectDelegate: class {
    func oneTextBarItemCellPressed(pressedIndex: Int)
}

class OOTDTextToolBar: UICollectionView {
    
    //ui
    private var cellTextColor : UIColor
    private var cellBgColor : UIColor
    private var cellHighlightColor : UIColor?
    private var textToolBarViewTag: String
    //data
    private var toolBarItemList: [OOTDTextToolBarModel] = []
    //delegate
    private weak var mapTextBarItemSelectDelegate: OOTDTextBarItemSelectDelegate?
    
    init(frame: CGRect, cellWidth : CGFloat, cellHeight: CGFloat,
         cellTextColor: UIColor, cellBgColor :UIColor, cellHighlightColor: UIColor?, toolBarItemList: [OOTDTextToolBarModel],
         delegate: OOTDTextBarItemSelectDelegate, viewTag: String ) {
        
        self.textToolBarViewTag = viewTag
        self.cellHighlightColor = cellHighlightColor
        self.cellTextColor = cellTextColor
        self.cellBgColor = cellBgColor
        self.mapTextBarItemSelectDelegate = delegate

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(OOTDTextToolBarCell.self, forCellWithReuseIdentifier: "OOTDTextToolBarCell")
        self.showsHorizontalScrollIndicator = false
        //self.automaticallyAdjustsScrollIndicatorInsets = false
        self.delegate = self
        self.dataSource = self
        
        self.layer.borderColor = OOTDConstant.universalColor.cgColor
        self.layer.borderWidth = 1
        
        self.toolBarItemList.append(contentsOf: toolBarItemList)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateToolBarItemList(toolBarItemList: [OOTDTextToolBarModel]){
        self.toolBarItemList.removeAll()
        self.toolBarItemList.append(contentsOf: toolBarItemList)
        self.reloadData()
        let defaultSelectCell = IndexPath(row: 0, section: 0)
        self.selectItem(at: defaultSelectCell, animated: true, scrollPosition: .left)
    }
}

extension OOTDTextToolBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toolBarItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OOTDTextToolBarCell", for: indexPath) as! OOTDTextToolBarCell
        cell.updateTextToolBarCell(toolBarItem: toolBarItemList[indexPath.row],
                                   textColor: self.cellTextColor,
                                   backgroundColor : self.cellBgColor,
                                   highlightColor: self.cellHighlightColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mapTextBarItemSelectDelegate?.oneTextBarItemCellPressed(pressedIndex: indexPath.row)
    }
}
