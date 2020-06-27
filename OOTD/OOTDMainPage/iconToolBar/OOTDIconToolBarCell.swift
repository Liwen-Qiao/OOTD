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
    
    private var toolBarIcon: UIImageView!
    private var toolBarHightLight: UIView!
    private var highlightColor: UIColor?
    
    override var isSelected: Bool {
        didSet {
            self.toolBarHightLight.backgroundColor = isSelected ? self.highlightColor : self.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        toolBarIcon = UIImageView()
        addSubview(toolBarIcon)
        toolBarIcon.easy.layout(CenterX(0), CenterY(0), Width(25), Height(25) )

        toolBarHightLight = UIView()
        addSubview(toolBarHightLight)
        //toolBarHightLight.backgroundColor = OOTDConstant.cloudColor
        toolBarHightLight.easy.layout([Bottom(0),Left(0),Right(0),Height(5)])
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func updateIconToolBarCell(toolBarItem: OOTDIconToolBarModel, highlightColor: UIColor?, backgroundColor: UIColor, iconHeight: CGFloat){
        toolBarIcon.image = UIImage(named: toolBarItem.toolBarItemLocalImage)
        toolBarIcon.easy.layout(CenterX(0), CenterY(0), Width(iconHeight), Height(iconHeight) )
        //toolBarIcon.kf.setImage(with: URL(string: toolBarItem.tooBarItemImageUrl))
        self.highlightColor = highlightColor
        self.backgroundColor = backgroundColor
        if let highlightColor = highlightColor {
            if isSelected == true{
                toolBarHightLight.backgroundColor = highlightColor
            }else{
                toolBarHightLight.backgroundColor = self.backgroundColor
            }
            toolBarHightLight.isHidden = false
        }
    }
}

