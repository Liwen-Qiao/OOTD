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
    private var wearRealmModel : WearRealmModel

    private var clothesList: [[ClothesRealmModel]] = []
    
    init(wearRealmModel: WearRealmModel){
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
        
        setupLayerView()
    
        setupClosetView()
        
        setupImageEditView()
        
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
    
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonClicked(){
    }
    
    //左边图层
    private func setupLayerView(){
//        var roleLayerProtocolList = [OOTDLayerProtocol]()
//        if self.roleFrameModel.roleLayerList == nil{
//            roleLayerProtocolList = []
//        }else{
//            if let roleLayerModelList = self.roleFrameModel.roleLayerList {
//                for onelayerModel in roleLayerModelList{
//                    roleLayerProtocolList.append(onelayerModel as! OOTDLayerProtocol)
//                }
//            }
//        }
//
//        layerView = OOTDLayerWithToolbarView(frame: CGRect.zero, layerList: roleLayerProtocolList, selectdelegate: self, showOrHideDelegate: self, toolbarDelegate: self)
//        self.view.addSubview(layerView)
//        layerView.easy.layout([Left(2),Top(62),Width(137),Height(200)])
//        layerView.updateLayerViewData(layerList: roleLayerProtocolList)
//        self.layerSeletedIndex = (self.roleFrameModel.roleLayerList?.count ?? 1) - 1
//        self.roleLayerSelected = self.roleFrameModel.roleLayerList?.lastObject as? OOTDRoleLayerModel
//
        //控制按钮
        layerViewButton = UIButton()
        layerViewButton.setImage(#imageLiteral(resourceName: "backBt-signIn"), for: .normal)
        layerViewButton.addTarget(self, action: #selector(self.layerViewButtonPressed), for: .touchUpInside)
        layerViewButton.layer.cornerRadius = 15
        self.view.addSubview(layerViewButton)
        layerViewButton.easy.layout([Left(0),Top(69.5),Width(25),Height(25)])
        layerViewButton.isSelected = false
    }
    
    //下面资源和工具栏，set up Draw Tool View
    private func  setupClosetView(){
        closetMainView = OOTDClosetView(frame: CGRect.zero, toolBarItemList: OOTDIconToolBarModel.getClothesTypeToolbarTools(), clothesItemList: clothesList,
        delegate: self, clothesPagerCellHeight: (UIScreen.main.bounds.height / 4 - 110))
        closetMainView.layer.borderColor = OOTDConstant.universalColor.cgColor
        closetMainView.layer.borderWidth = 2
        view.addSubview(closetMainView)
        closetMainView.easy.layout([Left(0),Bottom(0),Right(0),Height(UIScreen.main.bounds.height / 4)])
    }
    
    //主编辑区  setup main layout
    private func setupImageEditView(){
        clothesImageEditArea = OOTDClothesImageEditArea(frame: CGRect.zero,
                                                        wearModel: self.wearRealmModel,
                                                        stickerObjectEidtDelegate: self)
        self.view.addSubview(clothesImageEditArea)
        clothesImageEditArea.easy.layout([Left(0),Right(0),Top(60),Width(UIScreen.main.bounds.width),Height(UIScreen.main.bounds.width)])
    }
    
    //MARK: - button Action
    //左边 图层按钮事件 layerView show/hide
    @objc func layerViewButtonPressed(){
        if layerViewButton.isSelected == true {
            self.layerViewButton.setImage(#imageLiteral(resourceName: "foldLeft"), for: .normal)
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
            self.layerViewButton.setImage(#imageLiteral(resourceName: "foldRight"), for: .normal)
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
    private func saveTransparentImageFromImageEditArea(){
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
//        optionValue.updateValue(self.layerSeletedIndex, forKey: "layerIndex")
//        optionValue.updateValue(resourceInfo, forKey: "resourceInfo")
//        optionValue.updateValue(viewTag, forKey: "viewTag")
//        let redoStackInfo = OOTDRedoStack(redoKey: "addRoleElement", oppositeKey: "deleteRoleElement", optionValueDic: optionValue)
//        stackObjectProcess(action: "addRoleElement", optionValue: redoStackInfo)
//        self.addRoleElement(resourceInfo: resourceInfo, viewTag: viewTag, layerIndex: layerSeletedIndex)
    }
    
    func addButtonPressed() {
        //添加自己的照片
        //let addImageToResourcePage = OOTDImageAddToResourcePage(addNewImageDelegate: self)
       // self.navigationController?.pushViewController(addImageToResourcePage, animated: true)
    }
}

extension OOTDEditWearPage: OOTDSaveImageDelegate{
    func saveImagePerMoving() {
        self.saveTransparentImageFromImageEditArea()
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
