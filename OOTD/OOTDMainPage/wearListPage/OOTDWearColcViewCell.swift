//
//  OOTDWearColcViewCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDWearColcViewCell: UICollectionViewCell {
    
    private var wearIconView: UIImageView!
    //private var clotherTypeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        
        let bgView = UIView()
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowOffset = CGSize(width: 5, height: 5)
        bgView.layer.shadowRadius = 15
        bgView.layer.cornerRadius = 15
        addSubview(bgView)
        bgView.easy.layout(Edges(0))
        
        wearIconView = UIImageView()
        wearIconView.contentMode = .scaleAspectFill
        bgView.addSubview(wearIconView)
        wearIconView.layer.cornerRadius = 15
        wearIconView.clipsToBounds = true
        wearIconView.easy.layout(Edges(10))

//        clotherTypeLabel = UILabel()
//        addSubview(clotherTypeLabel)
//        //toolBarHightLight.backgroundColor = OOTDConstant.cloudColor
//        clotherTypeLabel.easy.layout([Bottom(0),Left(0),Right(0),Height(5)])
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func updateWearColcViewCell(wearModel: WearRealmModel){
        wearIconView.image = QImageFile.getDocumentImage(imagePath: "\(wearModel.wearMainImageType)/\(wearModel.wearMainImage)")
    }
}



