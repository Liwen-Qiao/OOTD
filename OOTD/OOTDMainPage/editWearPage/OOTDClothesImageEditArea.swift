//
//  OOTDClothesImageEditArea.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/27.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

//一个image 层，里面包含多个resource resouce 里面有文字和图片。
class OOTDClothesImageEditArea: UIView {
    
    private var resourceTagAndViewList: [(resourceTag: Int, resourceView: UIView)]  = []
    private var stikerViewList: [OOTDStickerView] = []
    
    private var wearRealmModel: WearRealmModel?
    private var wearCholthesList: [WearClothesRealmModel] = []
    //private weak var saveImageDelegate: QSaveImageDelegate?
    
    private weak var stickerObjectEidtDelegate: OOTDStickerObjectEidtDelegate?
    
    init(frame: CGRect, wearModel: WearRealmModel?, stickerObjectEidtDelegate: OOTDStickerObjectEidtDelegate) {
        
        self.wearRealmModel = wearModel
        self.stickerObjectEidtDelegate = stickerObjectEidtDelegate
        super.init(frame:frame)
        self.backgroundColor = .clear
        
        if let wearClothesList = self.wearRealmModel?.wearClothesList{
            for wearClothes in wearClothesList {
                wearCholthesList.append(wearClothes)
                addNewImageViewElement(clothesModel: wearClothes)
            }
        }
        
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Gesture
    @objc func tapGesture(_ sender: UIGestureRecognizer){
        
        for stikerView in stikerViewList{
            stikerView.isHidden = true
        }
        stikerViewList.removeAll()
        
        if sender.self.view?.tag == 0 {
            for oneTagAndImageView in resourceTagAndViewList{
                oneTagAndImageView.resourceView.isHidden = false
            }
        }else {
            let selectedViewTag = sender.self.view?.tag // 被点击的view
            
            if let tapIndex = self.resourceTagAndViewList.firstIndex(where: {$0.1.tag == selectedViewTag } ){
                let wearClothesModel = self.wearCholthesList[tapIndex]
                let stickerView = OOTDStickerView(objectModel: wearClothesModel,
                                                  delegate: self.stickerObjectEidtDelegate)
                stickerView.center = CGPoint(x: wearClothesModel.stickerViewLocationX, y: wearClothesModel.stickerViewLocationY)
                stickerView.transform = CGAffineTransform(rotationAngle: CGFloat(wearClothesModel.wearClothesRadian) )
                stikerViewList.append(stickerView)
                
                for oneResourceTagAndView in resourceTagAndViewList{
                    if oneResourceTagAndView.resourceView.tag == selectedViewTag{
                        oneResourceTagAndView.resourceView.isHidden = true
                    }else{
                        oneResourceTagAndView.resourceView.isHidden = false
                    }
                }
                self.addSubview(stickerView)
            }
        }
    }
    
    func addNewImageViewElement(clothesModel: WearClothesRealmModel){
        
        let oneItemImage = UIImageView(frame: CGRect( x: CGFloat(clothesModel.stickerViewLocationX),
                                                      y: CGFloat(clothesModel.stickerViewLocationY),
                                                      width: CGFloat(clothesModel.wearClothesWidth),
                                                      height: CGFloat(clothesModel.wearClothesHeight)))
        oneItemImage.center = CGPoint(x: clothesModel.stickerViewLocationX, y: clothesModel.stickerViewLocationY)
        oneItemImage.image = QImageFile.getDocumentImage(imagePath:"\(clothesModel.wearClothesMainImageType)/\(clothesModel.wearClothesMainImage)")
        oneItemImage.contentMode = .scaleAspectFill
        oneItemImage.transform = CGAffineTransform(rotationAngle: CGFloat(clothesModel.wearClothesRadian))
        oneItemImage.tag = Int(clothesModel.stickerViewId)
        
        //添加事件
        oneItemImage.isUserInteractionEnabled = true
        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        oneItemImage.addGestureRecognizer(tapGesture)
        wearCholthesList.append(clothesModel)
        //添加到 referenceList
        self.resourceTagAndViewList.append((Int(clothesModel.stickerViewId) , oneItemImage))
        //添加到 view
        addSubview(oneItemImage)
    }
    
    func stickerDeleted(clothesModel: StickerViewProtocol){
        if let deltIndex = self.wearRealmModel?.wearClothesList.index(of: clothesModel as! WearClothesRealmModel){
            self.wearRealmModel?.wearClothesList.remove(at: deltIndex)
            self.resourceTagAndViewList.remove(at: deltIndex )
        }
    }
    func stickerEidted(clothesModel: StickerViewProtocol) {
        let tag = clothesModel.stickerViewId
        if let tapIndex = self.resourceTagAndViewList.firstIndex(where: {$0.1.tag == tag}){
            self.wearRealmModel?.wearClothesList.replace(index: tapIndex, object: clothesModel as! WearClothesRealmModel)
            self.resourceTagAndViewList[tapIndex].resourceView.bounds = CGRect(  x: CGFloat(clothesModel.stickerViewLocationX),
                                                                                 y: CGFloat(clothesModel.stickerViewLocationY),
                                                                                 width: CGFloat(clothesModel.stickerViewWidth),
                                                                                 height: CGFloat(clothesModel.stickerViewHeight))
            self.resourceTagAndViewList[tapIndex ].resourceView.center = CGPoint(x: CGFloat(clothesModel.stickerViewLocationX),
                                                                                 y: CGFloat(clothesModel.stickerViewLocationY))
            self.resourceTagAndViewList[tapIndex].resourceView.transform = CGAffineTransform(rotationAngle: CGFloat(clothesModel.stickerViewRadian))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
            self.resourceTagAndViewList[tapIndex ].resourceView.addGestureRecognizer(tapGesture)
            
        }
    }
}

