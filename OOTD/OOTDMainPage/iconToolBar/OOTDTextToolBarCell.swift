//
//  OOTDTextToolBarCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDTextToolBarCell: UICollectionViewCell {
    //ui
    private var toolBarLabel: UILabel!
    private var toolBarHightLight: UIView!
    private var highlightColor: UIColor?
    //data
    private var toolBarItem: [OOTDTextToolBarModel] = []

    override var isSelected: Bool {
        didSet {
            self.toolBarHightLight.backgroundColor = isSelected ? self.highlightColor : self.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = OOTDConstant.universalColor
        toolBarLabel = UILabel()
        toolBarLabel.textAlignment = .center
        toolBarLabel.font = OOTDConstant.fontNormal
        toolBarLabel.textColor = .white
        addSubview(toolBarLabel)
        toolBarLabel.easy.layout(CenterY(0), Left(0), Right(0), Height(40))
        
        toolBarHightLight = UIView()
        addSubview(toolBarHightLight)
        toolBarHightLight.easy.layout([Bottom(0), Left(0), Right(0), Height(5)])
        toolBarHightLight.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func updateTextToolBarCell(toolBarItem: OOTDTextToolBarModel, textColor: UIColor, backgroundColor: UIColor, highlightColor: UIColor?){
        self.backgroundColor = backgroundColor
        self.toolBarLabel.textColor = textColor
        self.highlightColor = highlightColor
        self.toolBarLabel.text = toolBarItem.toolBarItemName
        if highlightColor != nil {
            if isSelected == true{
                toolBarHightLight.backgroundColor = self.highlightColor
            }else{
                toolBarHightLight.backgroundColor = self.backgroundColor
            }
            toolBarHightLight.isHidden = false
        }
    }
}
