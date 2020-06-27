//
//  OOTDClothesGridCell.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClothesGridCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 3 : 0.5
            self.layer.borderColor = isSelected ? OOTDConstant.universalColor.cgColor : OOTDConstant.cloudColor.cgColor
        }
    }
    
    func createdAddButton(){
        imageView.image = #imageLiteral(resourceName: "addResource")
        //imageView.easy.layout(Edges(10))
    }
    
    func updateGridCell(clothesModel: ClothesRealmModel){
        imageView.image = QImageFile.getDocumentImage(imagePath: "\(clothesModel.clothesMainImageType)/\(clothesModel.clothesMainImage)")
    }

    func loadImage(fileName: URL) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: fileName)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.easy.layout(Edges(3))
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = OOTDConstant.cloudColor.cgColor
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
