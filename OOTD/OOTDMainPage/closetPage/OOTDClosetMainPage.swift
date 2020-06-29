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
    private var clothesList: [[ClothesRealmModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let button = UIButton()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.alpha = 0.7
        button.setImage(#imageLiteral(resourceName: "addClothes"), for: .normal)
        let addButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        addButton.customView = button
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        button.easy.layout(Left(0),Right(0), Width(40), Height(30))
        navigationItem.setRightBarButton(addButton, animated: false)
        
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        let bg = UIImageView()
        
        bg.image = #imageLiteral(resourceName: "ClosetBg")
        bg.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(bg)
        bg.easy.layout([Edges(0)])
        
        setupClosetMainView()
        
        getReamlData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        topsClothesView.updateFrame()
        getReamlData()
    }
    
    func getReamlData(){
        
        let realm = try! Realm()
        //let predicate = NSPredicate(format: "userEmail = %@", email)
        let theClothesList = realm.objects(ClothesRealmModel.self)
        print("OOTDEditWearPage theClothesList\(theClothesList)")
        var theClothesArrayList : [ClothesRealmModel] = []
        theClothesArrayList.append(contentsOf: theClothesList)
        //self.clothesList.append(contentsOf: theClothesList)
        print("OOTDEditWearPage theClothesArrayList\(theClothesArrayList)")
        self.clothesList = ClothesRealmModel.classifyClothesByType(clothesList: theClothesArrayList, clothesType: [0,1,2,3,4,5,6,7])
        print("OOTDEditWearPage\(clothesList)")
        for clothesView in clothesViewList{
            for (index, clothes) in clothesList.enumerated(){
                if clothesView.tag == index{
                    clothesView.updateClothesNumber(clotherNumber: clothes.count)
                }
            }
        }
    }
    
    func setupClosetMainView(){
        noTypeClothesView = OOTDClothesTypeView(frame: CGRect(x: 50, y: 20, width: 60, height: 60), labelBgWidth: 130, delegate: self, tag: 0)
        noTypeClothesView.tag = 0
        self.view.addSubview(noTypeClothesView)
        noTypeClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "noTypeIcon"), clotherType: "No Category")
        clothesViewList.append(noTypeClothesView)
        noTypeClothesView.iconLogoViewnClicked(noTypeClothesView.iconLogoButton)
        
        topsClothesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 100, width: 60, height: 60), labelBgWidth: 80, delegate: self, tag: 1)
        topsClothesView.tag = 1
        self.view.addSubview(topsClothesView)
        topsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "wearIcon"), clotherType: "Top")
        clothesViewList.append(topsClothesView)
        
        dressClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 250, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 2)
        dressClothesView.tag = 2
        self.view.addSubview(dressClothesView)
        dressClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "dressIcon"), clotherType: "Dress")
        clothesViewList.append(dressClothesView)
        
        pantsClothesView = OOTDClothesTypeView(frame: CGRect(x: 180, y: 400, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 3)
        pantsClothesView.tag = 3
        self.view.addSubview(pantsClothesView)
        pantsClothesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "pantsIcon"), clotherType: "Pants")
        clothesViewList.append(pantsClothesView)
        
        shoesView = OOTDClothesTypeView(frame: CGRect(x: 240, y: 550, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 4)
        shoesView.tag = 4
        self.view.addSubview(shoesView)
        shoesView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "shoesIcon"), clotherType: "Shoes")
        clothesViewList.append(shoesView)
        
        bagsView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 450, width: 60, height: 60), labelBgWidth: 90, delegate: self, tag: 5)
        bagsView.tag = 5
        self.view.addSubview(bagsView)
        bagsView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "handbagsIcon"), clotherType: "Bags")
        clothesViewList.append(bagsView)
        
        accessoresView = OOTDClothesTypeView(frame: CGRect(x: 30, y: 165, width: 60, height: 60), labelBgWidth: 130, delegate: self, tag: 6)
        accessoresView.tag = 6
        self.view.addSubview(accessoresView)
        accessoresView.updateClothesTypeView(iconLogo: #imageLiteral(resourceName: "accessoriesIcon"), clotherType: "Accessores")
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
        //let closetMianView = OOTDOneTypeClothesMainPage(oneTypeClothesList: nil)
        let closetMianView = OOTDOneTypeClothesMainPage(oneTypeClothesList: self.clothesList[selectedViewTag])
        self.navigationController?.pushViewController(closetMianView, animated: true)
        
    }
    
    //export button event
    @objc func addButtonClicked(){
        let newPage = OOTDAddClothesItemPage()
        self.navigationController?.pushViewController(newPage, animated: true)
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
