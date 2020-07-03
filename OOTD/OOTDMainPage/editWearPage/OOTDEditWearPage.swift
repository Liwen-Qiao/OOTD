//
//  OOTDEditWearPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

protocol OOTDSaveImageDelegate: class{
    func saveImagePerMoving()
}

class OOTDEditWearPage: UIViewController {
    
    private var layerView: OOTDLayerEditPage!
    private var layerViewButton: UIButton!
    private var closetMainView: OOTDClosetView!
    private var clothesImageEditArea: OOTDClothesImageEditArea!
    
    //data
    private var wearRealmModel : WearRealmModel?
    
    private var clothesList: [[[ClothesRealmModel]]] = []
    private var wearClothesList: [WearClothesRealmModel] = []
    
    init(wearRealmModel: WearRealmModel?){
        self.wearRealmModel = wearRealmModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - /*--------- life cycle method ---------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavView()
        
        setupBackView()
        
        setupClosetView()
        
        setupImageEditView()
        
        setupLayerView()
        
        getClothesListFromRealm()
    
        //setupWearRealmModelData()
    }
    
    func setupNavView(){
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.edgesForExtendedLayout = []
        
        let leftBt = UIButton()
        leftBt.layer.cornerRadius = 0.5 * leftBt.bounds.size.width
        leftBt.alpha = 0.7
        leftBt.setImage(#imageLiteral(resourceName: "backBt"), for: .normal)
        let leftbutton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        leftbutton.customView = leftBt
        leftBt.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        leftBt.easy.layout(Left(0),Right(0), Width(30), Height(30))
        navigationItem.setLeftBarButton(leftbutton, animated: false)
        
        let saveBt = UIButton()
        saveBt.layer.cornerRadius = 0.5 * saveBt.bounds.size.width
        saveBt.alpha = 0.7
        saveBt.setImage(#imageLiteral(resourceName: "saveItem"), for: .normal)
        let rightbutton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        rightbutton.customView = saveBt
        saveBt.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        saveBt.easy.layout(Left(0),Right(0), Width(40), Height(30))
        navigationItem.setRightBarButton(rightbutton, animated: false)
    }
    
    func setupBackView(){
        let imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "SignBg")
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        imageView.easy.layout([Edges(0)])
    }
    
    //下面资源和工具栏，set up Draw Tool View
    private func  setupClosetView(){
        closetMainView = OOTDClosetView(frame: CGRect.zero,
                                        toolBarItemList: OOTDIconToolBarModel.getClothesTypeToolbarTools(),
                                        clothesItemList: clothesList,
                                        textToolBarItemList: OOTDTextToolBarModel.getClothesSubTypeToolbarTools(),
                                        delegate: self)
        closetMainView.layer.borderColor = OOTDConstant.darkBgColor.cgColor
        closetMainView.layer.borderWidth = 2
        view.addSubview(closetMainView)
        closetMainView.easy.layout([Left(0),Bottom(0),Right(0),Height(190)])
    }
    
    //主编辑区  setup main layout
    private func setupImageEditView(){
        
        clothesImageEditArea = OOTDClothesImageEditArea(frame: CGRect.zero,
                                                        wearModel: self.wearRealmModel,
                                                        stickerObjectEidtDelegate: self)
        clothesImageEditArea.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.view.addSubview(clothesImageEditArea)
        clothesImageEditArea.easy.layout([Left(0),Right(0),Top(0), Width(UIScreen.main.bounds.width), Bottom(0).to(closetMainView)])
    }
    
    func getClothesListFromRealm(){
        let realm = try! Realm()
        let theClothesList = realm.objects(ClothesRealmModel.self)
        var theClothesArrayList : [ClothesRealmModel] = []
        theClothesArrayList.append(contentsOf: theClothesList)
        self.clothesList = ClothesRealmModel.classifyClothesByType(clothesList: theClothesArrayList)
        closetMainView.updateTileclothesData(clothesItemList: clothesList)
    }
    
    //左边图层
    private func setupLayerView(){
        //todo
        layerView = OOTDLayerEditPage(frame: CGRect.zero, layerList: [], delegate: self)
        self.view.addSubview(layerView)
        layerView.easy.layout([Right(10),Bottom(10).to(closetMainView),Width(150),Height(200)])
        
        if let wearRealmModel = self.wearRealmModel{
            wearClothesList.append(contentsOf: wearRealmModel.wearClothesList)
            layerView.updateLayerList(layerList: wearClothesList)
        }
        
        layerViewButton = UIButton()
        layerViewButton.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        layerViewButton.layer.shadowColor = UIColor.darkGray.cgColor
        layerViewButton.layer.cornerRadius = 12.5
        layerViewButton.layer.shadowOpacity = 0.5
        layerViewButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        layerViewButton.layer.shadowRadius = 15
        layerViewButton.setImage(#imageLiteral(resourceName: "layerEdit"), for: .normal)
        layerViewButton.addTarget(self, action: #selector(self.layerViewButtonPressed), for: .touchUpInside)
        self.view.addSubview(layerViewButton)
        layerViewButton.easy.layout([Right(20),Bottom(20).to(closetMainView),Width(25),Height(25)])
        layerViewButton.isSelected = false
    }
    
    //MARK: - button Action
    
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonClicked(){
        if let wearRealmModel = self.wearRealmModel{
            let realm = try! Realm()
            try! realm.write {
                if wearRealmModel.wearClothesList.count > 0{
                    wearRealmModel.wearClothesList.removeAll()
                }
                wearRealmModel.wearClothesList.append(objectsIn: self.wearClothesList)
                saveTransparentImageFromImageEditArea(wearRealmModel: wearRealmModel)
            }
        }else{
            let realm = try! Realm()
            try! realm.write {
                let newWearRealmModel = WearRealmModel(value: ["wearType": 0, "wearSubType": 0, "wearMainImageType": "wearMainImage", "wearMainImage": "\(OOTDConstant.getTimeString()).png" ])
                newWearRealmModel.wearClothesList.append(objectsIn: self.wearClothesList)
                realm.add(newWearRealmModel, update: .modified)
                saveTransparentImageFromImageEditArea(wearRealmModel: newWearRealmModel)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    @objc func layerViewButtonPressed(){
        if layerViewButton.isSelected == true {
            self.layerViewButton.setImage(#imageLiteral(resourceName: "layerEdit"), for: .normal)
            self.layerView.isHidden = false
            let transition:CATransition = CATransition()
            transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        layerView.easy.layout([Top(62), Left(2), Width(137), Height(200)])
        layerView.layer.add(transition, forKey: kCATransition)
        layerViewButton.layer.add(transition, forKey: kCATransition)
        layerViewButton.isSelected = false
    } else {
        self.layerViewButton.setImage(#imageLiteral(resourceName: "layerEdit"), for: .normal)
        self.layerView.isHidden = true
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        layerView.layer.add(transition, forKey: kCATransition)
        layerViewButton.layer.add(transition, forKey: kCATransition)
        layerView.easy.layout([Top(62),Left(-139),Width(137),Height(200)])
        layerViewButton.isSelected = true
    }
}

//保存图片数据  截出透明的图 并且保存本地 根据 roleFrameModel 来保存图片到相关地址
    private func saveTransparentImageFromImageEditArea(wearRealmModel: WearRealmModel){
    UIGraphicsBeginImageContextWithOptions(self.clothesImageEditArea.layer.frame.size, false, 0)
    guard let uiGraphicsGetCurrentContext = UIGraphicsGetCurrentContext() else { return }
    self.clothesImageEditArea.layer.render(in: uiGraphicsGetCurrentContext )
    guard let viewImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()
    QImageFile.saveImageByNameAndLocation(image: viewImage, name: wearRealmModel.wearMainImage, location: wearRealmModel.wearMainImageType)
}
}

extension OOTDEditWearPage: OOTDLayerInfoUpdateDelegate{
    func layerInfoUpdate(layerList: [WearClothesRealmModel]) {
    }
}

extension OOTDEditWearPage: OOTDClothesItemSelectDelegate{
    func oneClothesItemPressed(clothesInfo: ClothesRealmModel) {
        let newWearClothesModel = WearClothesRealmModel()
        newWearClothesModel.wearClothesMainImage = clothesInfo.clothesMainImage
        newWearClothesModel.wearClothesMainImageType = clothesInfo.clothesMainImageType
        self.wearClothesList.append(newWearClothesModel)
        layerView.updateLayerList(layerList: self.wearClothesList)
        clothesImageEditArea.addNewImageViewElement(clothesModel: newWearClothesModel)
    }
}

extension OOTDEditWearPage: OOTDStickerObjectEidtDelegate{
    
    func stickerObjectDeleted(objectModel: StickerViewProtocol) {
        clothesImageEditArea.stickerDeleted(clothesModel: objectModel)
    }
    
    func stickerObjectEidted(objectModel: StickerViewProtocol) {
        clothesImageEditArea.stickerEidted(clothesModel: objectModel)
    }
}
