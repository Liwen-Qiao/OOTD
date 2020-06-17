//
//  OOTDClosetMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDClosetMainPage: UIViewController{
    
    private var clothesTypeView: OOTDClosetMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        let bg = UIImageView()
        bg.image = #imageLiteral(resourceName: "ClosetBg")
        bg.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(bg)
        bg.easy.layout([Edges(0)])
        setupClosetMainView()
    }
    
    func setupClosetMainView(){
        clothesTypeView = OOTDClosetMainView(frame: CGRect.zero, delegate: self)
        clothesTypeView.backgroundColor = .clear
        self.view.addSubview(clothesTypeView)
        clothesTypeView.easy.layout(Edges(0))
    }
    
}

extension OOTDClosetMainPage: OOTDClothesTypeSelectDelegate{
    func oneClothesTypePressed(pressedIndex: Int) {
       
    }
}
