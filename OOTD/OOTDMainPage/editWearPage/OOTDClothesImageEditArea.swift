//
//  OOTDClothesImageEditArea.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/27.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

//一个image 层，里面包含多个resource resouce 里面有文字和图片。
class OOTDClothesImageEditArea: UIView {
    
    private var resourceTagAndViewList: [(resourceTag: Int, resourceView: UIView)]  = []
    private var stikerViewList: [OOTDStickerView] = []
    
    private var wearRealmModel: WearRealmModel
    
    //private weak var saveImageDelegate: QSaveImageDelegate?
    
    private weak var stickerObjectEidtDelegate: OOTDStickerObjectEidtDelegate?
    
    init(frame: CGRect, wearModel: WearRealmModel, stickerObjectEidtDelegate: OOTDStickerObjectEidtDelegate) {
        
        self.wearRealmModel = wearModel
        self.stickerObjectEidtDelegate = stickerObjectEidtDelegate
        super.init(frame:frame)
        self.backgroundColor = .clear
        
//        //添加图片资源
//        if let theRoleElementList = self.roleLayerModel.roleElementList{
//            for oneElement in theRoleElementList {
//                if let oneElementModel = oneElement as? GMRoleElementModel{
//                    //服务器的element 是0 ， 图片是2  //文字是1
//                    if oneElementModel.roleElementType == 0 || oneElementModel.roleElementType == 2{
//                        addNewImageViewElement(resourceModel: oneElementModel)
//                    }
//                    //文字是1
//                    else if oneElementModel.roleElementType == 1{
//                        addNewLabelElement(roleTextElement: oneElementModel)
//                    }else {}
//                }
//            }
//        }
        
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Gesture
    @objc func tapGesture(_ sender: UIGestureRecognizer){
        
        //把所有stikerView隐藏
        for stikerView in stikerViewList{
            stikerView.isHidden = true
        }
        
        //从列表移除
        stikerViewList.removeAll()
 
        //当点击到[背景区域]的时候。   显示所有的ImageView. 因为只有背景区域是0, 非sticker的区域的tag 为0，
        if sender.self.view?.tag == 0 {
            for oneTagAndImageView in resourceTagAndViewList{
                oneTagAndImageView.resourceView.isHidden = false
            }
        }
            
        //点击到[sticker]的时候
        else {
            let selectedViewTag = sender.self.view?.tag // 被点击的view
  
            //根据点击的view，来获取index，  根据被点击的view获取tag，然后用tag获取，当前view在list的index。    // 从一个元素中的tuple的第二个元素的tag
            if let tapIndex = self.resourceTagAndViewList.firstIndex(where: {$0.1.tag == selectedViewTag } ){
//                //根据index获取elementModel
//                //if let roleElementModel = self.roleLayerModel.roleElementList?.object(at: tapIndex ) as?  GMRoleElementModel {
//                    //根据GMMapObjectLayerModel 创建一个GMStickerView
//                    let stickerView = OOTDStickerView(objectModel: roleElementModel,
//                                                    viewType: "RoleElement",
//                                                    delegate: stickerObjectEidtDelegate)
//                    stickerView.center = CGPoint(x: roleElementModel.stickerViewLocationX, y: roleElementModel.stickerViewLocationY)
//                    stickerView.transform = CGAffineTransform(rotationAngle: CGFloat(roleElementModel.roleElementRadian) )
//                    stikerViewList.append(stickerView)
//
//                    //在 resourceTagAndViewList 找到被选中View，然后隐藏起来，之后为了让stickerView显示
//                    for oneResourceTagAndView in resourceTagAndViewList{
//                        if oneResourceTagAndView.resourceView.tag == selectedViewTag{
//                            oneResourceTagAndView.resourceView.isHidden = true
//                        }else{
//                            oneResourceTagAndView.resourceView.isHidden = false
//                        }
//                    }
//                    self.addSubview(stickerView)
//               // }
            }
        }
    }
    
    func addNewImageViewElement(resourceModel: WearClothesRealmModel){
        //添加 coredata 的 roleLayerModel
//        self.roleLayerModel.addToRoleElementList(resourceModel)
//
//        //根据 ElementModel 创建 UIImageView
//        let oneResourceImage = UIImageView(frame: CGRect( x: CGFloat(resourceModel.roleElementLocationX),
//                                                          y: CGFloat(resourceModel.roleElementLocationY),
//                                                          width: CGFloat(resourceModel.roleElementHeight),
//                                                          height: CGFloat(resourceModel.roleElementHeight)))
//        oneResourceImage.center = CGPoint(x: resourceModel.stickerViewLocationX, y: resourceModel.stickerViewLocationY)
//        oneResourceImage.image = QImageFile.getDocumentImage(imagePath:"\(resourceModel.resourceMainImageType)/\(resourceModel.resourceMainImage)")
//        oneResourceImage.transform = CGAffineTransform(rotationAngle: CGFloat(resourceModel.roleElementRadian))
//        oneResourceImage.tag = Int(resourceModel.roleElementId)
//
//        //添加事件
//        oneResourceImage.isUserInteractionEnabled = true
//        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
//        oneResourceImage.addGestureRecognizer(tapGesture)
//
//        //添加到 referenceList
//        self.resourceTagAndViewList.append((Int(resourceModel.resourceId) ?? 0, oneResourceImage))
//        //添加到 view
//        addSubview(oneResourceImage)
//        //self.saveImageDelegate?.saveImagePerMoving()
    }
    
    func stickerDeleted(clothesModel: StickerViewProtocol){
//       if let deltIndex = self.roleLayerModel.roleElementList?.index(of: elementModel as?  GMRoleElementModel ?? GMRoleElementModel()){
//            // 从 coredata 的 roleLayerModel 删除
//            self.roleLayerModel.removeFromRoleElementList(elementModel as? GMRoleElementModel ?? GMRoleElementModel() )
//            // 从 referenceList 删除
//            self.resourceTagAndViewList.remove(at: deltIndex )
//            //合并 多层图片数据 成一张图片，保存到本地文件夹
//            self.saveImageDelegate?.saveImagePerMoving()
//        }
    }
//
    func stickerEidted(clothesModel: StickerViewProtocol) {
//        guard let roleElementModel = elementModel as? GMRoleElementModel else { return }
//        let tag = elementModel.stickerViewId
//        if let tapIndex = self.resourceTagAndViewList.firstIndex(where: {$0.1.tag == tag}){
//
//            self.roleLayerModel.replaceRoleElementList(at: tapIndex, with: roleElementModel)
//            self.resourceTagAndViewList[tapIndex].resourceView.bounds = CGRect(  x: CGFloat(elementModel.stickerViewLocationX),
//                                                                                 y: CGFloat(elementModel.stickerViewLocationY),
//                                                                                 width: CGFloat(elementModel.stickerViewWidth),
//                                                                                 height: CGFloat(elementModel.stickerViewHeight))
//            self.resourceTagAndViewList[tapIndex ].resourceView.center = CGPoint(x: CGFloat(elementModel.stickerViewLocationX),
//                                                                                 y: CGFloat(elementModel.stickerViewLocationY))
//            if let objectRadian = elementModel.stickerViewRadian{
//                self.resourceTagAndViewList[tapIndex].resourceView.transform = CGAffineTransform(rotationAngle: CGFloat(objectRadian))
//            }
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
//            self.resourceTagAndViewList[tapIndex ].resourceView.addGestureRecognizer(tapGesture)
//            self.saveImageDelegate?.saveImagePerMoving()
//        }
   }
}

