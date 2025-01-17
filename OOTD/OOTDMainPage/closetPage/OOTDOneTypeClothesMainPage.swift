//
//  OOTDOneTypeClothesMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/19.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

class OOTDOneTypeClothesMainPage: UIViewController{
    
    private var oneTypeClothesColcView: OOTDOneTypeClothesColcView!
    private var oneTypeClothesList: [ClothesRealmModel]? = []
    
    init(oneTypeClothesList: [ClothesRealmModel]?) {
        self.oneTypeClothesList = oneTypeClothesList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        let bg = UIImageView()
        
        bg.image = #imageLiteral(resourceName: "wearBg")
        bg.contentMode = .scaleAspectFill
        bg.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(bg)
        bg.easy.layout([Edges(0)])
        
        setupClothesColcView()
    }
    
    func setupClothesColcView(){
        oneTypeClothesColcView = OOTDOneTypeClothesColcView(frame: CGRect.zero, oneTypeClothesList: oneTypeClothesList ?? [])
        oneTypeClothesColcView.backgroundColor = OOTDConstant.lightUniversalColor.withAlphaComponent(0.5)
        self.view.addSubview(oneTypeClothesColcView)
        oneTypeClothesColcView.easy.layout([Edges(10)])
    }
}
