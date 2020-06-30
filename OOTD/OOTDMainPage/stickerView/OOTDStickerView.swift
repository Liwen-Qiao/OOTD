//
//  OOTDStickerView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/27.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

protocol OOTDStickerObjectEidtDelegate: class {
    func stickerObjectEidted(objectModel: StickerViewProtocol)
    func stickerObjectDeleted(objectModel: StickerViewProtocol)
}

class OOTDStickerView: UIView {
    
    //ui
    private var selectedImageView: UIImageView!  //中间的图片
    private var selectedTextLabel: UILabel!
    private var selectedImageViewBorder: CAShapeLayer! //图片周围的虚线
    
    //variable
    private let defaultBorder: Int = 15 //中间图像和虚线的边缘的距离
    private let minimumSize: Int = 0  //???
    private let maxScale: CGFloat = 4   //最大倍数是4
    
    private var rotateAngle: CGFloat = 0
    private var radian: CGFloat = 0           //
    private var initialBounds = CGRect.zero   //一开始的图片大小
    private var initialDistance: CGFloat = 0  //手指按住的点 和 图片中心之间的距离
    
    private var stickerViewType: String = ""
    
    private var stickerViewData: StickerViewProtocol?
    
    private weak var gmObjectEidtDelegate: OOTDStickerObjectEidtDelegate?
    
    
    //MARK: - init
    init(objectModel: StickerViewProtocol?, delegate: OOTDStickerObjectEidtDelegate? ){
        
        self.stickerViewData = objectModel
        
        let frameWidth = (objectModel?.stickerViewWidth ?? 80) + self.defaultBorder * 2
        let frameHeight = (objectModel?.stickerViewHeight ?? 80) + self.defaultBorder * 2
        let frame = CGRect(x: objectModel?.stickerViewLocationX ?? 20,
                           y: objectModel?.stickerViewLocationY ?? 20,
                           width: frameWidth,
                           height: frameHeight)
        super.init(frame: frame)
        
        //中间的imageView
        selectedImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: objectModel?.stickerViewWidth ?? 80, height: objectModel?.stickerViewHeight ?? 80))
        if let objectModel = objectModel{
            selectedImageView.image = QImageFile.getDocumentImage(imagePath: "\(objectModel.stickerViewMainImageType)/\(objectModel.stickerViewMainImage)")
        }else {
        }
        selectedImageView.tag = objectModel?.stickerViewId ?? 0
        selectedImageView.isUserInteractionEnabled = false
        selectedImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        selectedImageView.layer.allowsEdgeAntialiasing = true
        //图片周围的虚线
        selectedImageViewBorder = CAShapeLayer()
        selectedImageViewBorder.strokeColor = OOTDConstant.universalColor.cgColor
        selectedImageViewBorder.lineDashPattern = [8, 6]
        selectedImageViewBorder.lineWidth = 2
        selectedImageViewBorder.fillColor = nil
        selectedImageView.layer.addSublayer(selectedImageViewBorder)
        selectedImageViewBorder.frame = selectedImageView.bounds
        selectedImageViewBorder.path = UIBezierPath(rect: selectedImageView.bounds).cgPath
        self.addSubview(selectedImageView)
        
        //关闭按钮
        let toolFrame = CGRect(x: 0, y: 0, width: self.defaultBorder * 2, height: self.defaultBorder * 2)
        let closeButton = UIButton()
        closeButton.frame = toolFrame
        closeButton.setImage(#imageLiteral(resourceName: "closeBt"), for: .normal)
        closeButton.addTarget(self, action: #selector(self.closeButtonPressed(_:)), for: .touchUpInside) //设置关闭事件
        self.addSubview(closeButton)
        closeButton.easy.layout([Left(0),Top(0)])
        
        //旋转按钮
        let rorateView = UIImageView()
        rorateView.frame = toolFrame
        rorateView.image = #imageLiteral(resourceName: "rotateBt")
        rorateView.isUserInteractionEnabled = true
        let rotateGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRotateGesture(_:)))
        rorateView.addGestureRecognizer(rotateGesture)//设置旋转事件
        self.addSubview(rorateView)
        rorateView.easy.layout([Right(0),Bottom(0)])
        
        //设置移动事件
        //让整个StickerView来移动
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(sender:)))
        self.addGestureRecognizer(panGestureRecognizer)
        
        //addPinchGesture(view: self)
        self.gmObjectEidtDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // comment method  //todo9:可以移除到一个单独的class
    private func getDistanceOfCGPoint(point1:CGPoint, point2:CGPoint) -> CGFloat {
        let fx = point2.x - point1.x
        let fy = point2.y - point1.y
        return sqrt(fx * fx + fy * fy)
    }
    
    //MARK: - 删除操作 把当前view移除，调用delegate处理相关的数据删除
    @objc func closeButtonPressed(_ sender: UIButton){
        self.removeFromSuperview()
        if let stickerViewData = stickerViewData{
            gmObjectEidtDelegate?.stickerObjectDeleted(objectModel: stickerViewData)
        }
    }
    
    //MARK: - 移动操作 Pan  移动整个view
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        switch sender.state {
        case .began, .changed:
            let translation = sender.translation(in: fileView)
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: fileView)
        case .ended:
            let realm = try! Realm()
            try! realm.write {
                self.stickerViewData?.stickerViewLocationX = Int(fileView.center.x)
                self.stickerViewData?.stickerViewLocationY = Int(fileView.center.y)
                if let stickerViewData = stickerViewData{
                    gmObjectEidtDelegate?.stickerObjectEidted(objectModel: stickerViewData)
                }
            }
        default:
            break
        }
    }
    
    //MARK: - 旋转操作 只是移动右下角的按钮
    @objc func handleRotateGesture(_ recognizer: UIPanGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        switch recognizer.state {
        case .began:
            self.rotateAngle = CGFloat(atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))) - atan2(self.transform.b, self.transform.a)
            
            self.initialBounds = selectedImageView.bounds
            self.initialDistance = getDistanceOfCGPoint(point1: center, point2: touchLocation)
        case .changed:
            let angle = atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))
            let angleRotated = Float(self.rotateAngle) - angle
            self.radian = CGFloat(-angleRotated)
            self.transform = CGAffineTransform(rotationAngle: radian)
            var scale = getDistanceOfCGPoint(point1: center, point2: touchLocation) / self.initialDistance
            let minimumScale = CGFloat(self.minimumSize) / min(self.initialBounds.size.width + CGFloat(defaultBorder * 2), self.initialBounds.size.height +  CGFloat(defaultBorder * 2))
            scale = max(scale, minimumScale)
            scale = min(scale, maxScale)
            selectedImageView.bounds = CGRect(x: self.initialBounds.origin.x, y: self.initialBounds.origin.y, width: self.initialBounds.size.width * scale, height: self.initialBounds.size.height * scale)
            selectedImageViewBorder.path = UIBezierPath(rect: selectedImageView.bounds).cgPath
            self.bounds = CGRect(x:self.bounds.origin.x , y: self.bounds.origin.y, width: selectedImageView.bounds.size.width + CGFloat(self.defaultBorder) * 2, height: selectedImageView.bounds.size.height + CGFloat(self.defaultBorder) * 2)
            self.setNeedsDisplay()
        case .ended:
            let realm = try! Realm()
            try! realm.write {
                self.stickerViewData?.stickerViewLocationX = Int(self.center.x)
                self.stickerViewData?.stickerViewLocationY = Int(self.center.y)
                self.stickerViewData?.stickerViewWidth = Int(selectedImageView.bounds.width)
                self.stickerViewData?.stickerViewHeight = Int(selectedImageView.bounds.height)
                self.stickerViewData?.stickerViewRadian = radian
                if let stickerViewData = stickerViewData{
                    gmObjectEidtDelegate?.stickerObjectEidted(objectModel: stickerViewData)
                }
            }
        default:
            break
        }
    }
}
