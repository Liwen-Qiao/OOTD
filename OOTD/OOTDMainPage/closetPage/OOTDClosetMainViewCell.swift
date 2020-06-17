//
//  OOTDClosetMainViewCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/17.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClosetMainViewCell: UICollectionViewCell {
    
    private var clotherTypeIconView: UIImageView!
    private var clotherTypeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clotherTypeIconView = UIImageView()
        addSubview(clotherTypeIconView)
        clotherTypeIconView.easy.layout(CenterX(0), CenterY(0), Width(25), Height(25) )

        clotherTypeLabel = UILabel()
        addSubview(clotherTypeLabel)
        //toolBarHightLight.backgroundColor = GMConstant.cloudColor
        clotherTypeLabel.easy.layout([Bottom(0),Left(0),Right(0),Height(5)])
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func updateClosetTypeViewCell(clotherTypeIcon: UIImage, clotherType: String){
        clotherTypeIconView.image = clotherTypeIcon
        clotherTypeLabel.text = clotherType
    }
}


