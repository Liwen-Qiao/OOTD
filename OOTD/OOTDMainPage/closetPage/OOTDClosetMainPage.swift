//
//  OOTDClosetMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

class OOTDClosetMainPage: UIViewController{
  
    private var noTypeClothesView: OOTDClothesTypeView!
    private var topsClothesView: OOTDClothesTypeView!
    private var dressClothesView: OOTDClothesTypeView!
    private var pantsClothesView: OOTDClothesTypeView!
    private var shoesView: OOTDClothesTypeView!
    private var bagsView: OOTDClothesTypeView!
    private var accessoresView: OOTDClothesTypeView!
    
    private var clothesViewList: [OOTDClothesTypeView] = []
    private var clothesList: [ClothesRealmModel] = []
    
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
        
        getReamlData()
        
        setupClosetMainView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topsClothesView.updateFrame()
    }
    
    func getReamlData(){
        
        let realm = try! Realm()
        //let predicate = NSPredicate(format: "userEmail = %@", email)
        let theClothesList = realm.objects(ClothesRealmModel.self)
        self.clothesList.append(contentsOf: theClothesList)
        
        print("衣服列表为\(clothesList)")
        
        
    }
    
    func setupClosetMainView(){
        noTypeClothesView = OOTDClothesTypeView(frame: CGRect(x: 50, y: 20, width: 60, height: 60), labelBgWidth: 130, delegate: self, tag: 1)
        noTypeClothesView.tag = 1
        self.view.addSubview(noTypeClothesView)
        noTypeClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "No Category", clotherNumber: 7)
        clothesViewList.append(noTypeClothesView)
        
        topsClothesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 100, width: 60, height: 60), labelBgWidth: 80, delegate: self, tag: 2)
        topsClothesView.tag = 2
        self.view.addSubview(topsClothesView)
        topsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "wearIcon"), clotherType: "Top", clotherNumber: 5)
        clothesViewList.append(topsClothesView)
        
        dressClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 250, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 3)
        dressClothesView.tag = 3
        self.view.addSubview(dressClothesView)
        dressClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Dress", clotherNumber: 7)
        clothesViewList.append(dressClothesView)

        pantsClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 400, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 4)
        pantsClothesView.tag = 4
        self.view.addSubview(pantsClothesView)
        pantsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Pants", clotherNumber: 7)
        clothesViewList.append(pantsClothesView)

        shoesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 550, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 4)
        shoesView.tag = 5
        self.view.addSubview(shoesView)
        shoesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Shoes", clotherNumber: 7)
        clothesViewList.append(shoesView)

        bagsView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 450, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 5)
        bagsView.tag = 6
        self.view.addSubview(bagsView)
        bagsView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Bags", clotherNumber: 7)
        clothesViewList.append(bagsView)

        accessoresView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 165, width: 60, height: 60), labelBgWidth: 130, delegate: self, tag: 6)
        accessoresView.tag = 7
        self.view.addSubview(accessoresView)
        accessoresView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "closetIcon"), clotherType: "Accessores", clotherNumber: 7)
        clothesViewList.append(accessoresView)
        
        for clothesView in clothesViewList{
            clothesView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
            clothesView.addGestureRecognizer(tapGesture)
        }
    }
    
    //MARK: - Gesture
    @objc func tapGesture(_ sender: UIGestureRecognizer){
        guard let selectedViewTag = sender.self.view?.tag else { return }
        let closetMianView = OOTDOneTypeClothesMainPage(oneTypeClothesList: nil)
        //let closetMianView = OOTDOneTypeClothesMainPage(oneTypeClothesList: [self.clothesList[selectedViewTag]])
        self.navigationController?.pushViewController(closetMianView, animated: true)
            
    }
}

extension OOTDClosetMainPage: ClothesTypeBtSelectedDelegate{
    func btClicked(viewTag: Int) {
        for clothesView in clothesViewList{
            if clothesView.tag == viewTag{
                continue
            }else{
                clothesView.updateFrame()
            }
        }
    }
}
