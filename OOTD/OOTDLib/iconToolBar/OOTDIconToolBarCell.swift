//
//  OOTDIconToolBarCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDIconToolBarCell: UICollectionViewCell {
    
    private var toolBarIconView: UIView!
    private var toolBarIcon: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            toolBarIconView.layer.borderColor = isSelected ? OOTDConstant.white.cgColor : OOTDConstant.universalColor.cgColor.copy(alpha: 0.8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = OOTDConstant.darkBgColor
        toolBarIconView = UIView()
        toolBarIconView.backgroundColor = OOTDConstant.universalColor
        toolBarIconView.layer.borderColor = OOTDConstant.universalColor.cgColor.copy(alpha: 0.8)
        toolBarIconView.layer.borderWidth = 3
        toolBarIconView.layer.cornerRadius = 22.5
        addSubview(toolBarIconView)
        toolBarIconView.easy.layout(CenterX(0), CenterY(0), Width(45), Height(45) )
        
        toolBarIcon = UIImageView()
        toolBarIcon.clipsToBounds = true
        toolBarIconView.addSubview(toolBarIcon)
        toolBarIcon.easy.layout(CenterX(0), CenterY(0), Width(25), Height(25) )
        
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func updateIconToolBarCell(toolBarItem: OOTDIconToolBarModel){
        toolBarIcon.image = UIImage(named: toolBarItem.toolBarItemLocalImage)
    }
}

