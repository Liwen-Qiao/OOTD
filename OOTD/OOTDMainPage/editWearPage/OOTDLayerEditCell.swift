//
//  OOTDLayerEditCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy


class OOTDLayerEditCell: UITableViewCell {
      
    private var layerImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.selectionStyle = .none
        
        layerImageView = UIImageView()
        addSubview(layerImageView)
        layerImageView.easy.layout([CenterX(0), CenterY(0), Height(25),Width(25)])
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    func updateLayerCell(layerWearClothes: WearClothesRealmModel){
        self.layerImageView.image = QImageFile.getDocumentImage(imagePath: "\(layerWearClothes.wearClothesMainImageType)/\(layerWearClothes.wearClothesMainImage)")
    }
}

