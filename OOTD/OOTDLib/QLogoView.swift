//
//  QLogoView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class QLogoView: UIView {
    
    private var iconImageView: UIImageView!
    
    init(frame: CGRect, isChanged: Bool) {
        super.init(frame:frame)
        
        iconImageView = UIImageView()
        if isChanged == false{
            iconImageView.image = #imageLiteral(resourceName: "wearSelectedIcon")}
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 40
        self.layer.borderColor = OOTDConstant.darkBgColor.cgColor.copy(alpha: 0.8)
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 50
        //self.layer.shadowColor = OOTDConstant.darkBgColor.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.layer.shadowRadius = 15
        self.addSubview(iconImageView)
        iconImageView.easy.layout(Edges(10))
        self.easy.layout([Width(100),Height(100)])
        if isChanged == true{
            iconImageView.image = #imageLiteral(resourceName: "addIcon")
            iconImageView.isUserInteractionEnabled = true
        }
    }
    
    func updateIconImageView(IconImage: UIImage){
        iconImageView.image = IconImage
    }
    
    func getIconImageViewImage() -> UIImage{
        return iconImageView.image ?? UIImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



