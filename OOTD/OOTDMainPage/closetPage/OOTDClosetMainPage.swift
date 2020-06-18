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
  
    private var noTypeClothesView: OOTDClothesTypeView!
    private var topsClothesView: OOTDClothesTypeView!
    private var dressClothesView: OOTDClothesTypeView!
    private var pantsClothesView: OOTDClothesTypeView!
    private var shoesView: OOTDClothesTypeView!
    private var bagsView: OOTDClothesTypeView!
    private var accessoresView: OOTDClothesTypeView!
    
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
    override func viewWillAppear(_ animated: Bool) {
        topsClothesView.updateFrame()
    }
    
    func setupClosetMainView(){
        
        noTypeClothesView = OOTDClothesTypeView(frame: CGRect(x: 50, y: 20, width: 60, height: 60), labelBgWidth: 130)
        noTypeClothesView.tag = 2
        self.view.addSubview(noTypeClothesView)
        noTypeClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "No Category", clotherNumber: 7)
        
        topsClothesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 100, width: 60, height: 60), labelBgWidth: 80)
        topsClothesView.tag = 0
        self.view.addSubview(topsClothesView)
        topsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "wearIcon"), clotherType: "Top", clotherNumber: 5)
        
        dressClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 250, width: 60, height: 60), labelBgWidth: 90)
        dressClothesView.tag = 1
        self.view.addSubview(dressClothesView)
        dressClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Dress", clotherNumber: 7)
        
        pantsClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 400, width: 60, height: 60), labelBgWidth: 90)
        pantsClothesView.tag = 2
        self.view.addSubview(pantsClothesView)
        pantsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Pants", clotherNumber: 7)
        
        shoesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 550, width: 60, height: 60), labelBgWidth: 90)
        shoesView.tag = 2
        self.view.addSubview(shoesView)
        shoesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Shoes", clotherNumber: 7)
        
        bagsView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 450, width: 60, height: 60), labelBgWidth: 90)
        bagsView.tag = 2
        self.view.addSubview(bagsView)
        bagsView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Bags", clotherNumber: 7)
        
        accessoresView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 165, width: 60, height: 60), labelBgWidth: 130)
        accessoresView.tag = 2
        self.view.addSubview(accessoresView)
        accessoresView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Accessores", clotherNumber: 7)
        
        
        
        
        
//        topsClothesBt = UIButton()
//        topsClothesBt.backgroundColor =  OOTDConstant.darkBgColor.withAlphaComponent(0.5)
//        topsClothesBt.addTarget(self.topsClothesView, action: #selector(clothesTypeButtonClicked(_:)), for: .touchUpInside)
//        self.view.addSubview(topsClothesBt)
//        topsClothesBt.easy.layout([Left(100), Top(100), Height(30), Width(30)])
        

//        let Dress = OOTDClothesTypeView()
//        self.view.addSubview(Dress)
//        Dress.easy.layout([Left(190), Top(250), Height(60), Width(150)])
//        Dress.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetSelectedIcon"), clotherType: "Dress", clotherNumber: 20)
    }
    
}

extension OOTDClosetMainPage: OOTDClothesTypeSelectDelegate{
    func oneClothesTypePressed(pressedIndex: Int) {
        
    }
}
