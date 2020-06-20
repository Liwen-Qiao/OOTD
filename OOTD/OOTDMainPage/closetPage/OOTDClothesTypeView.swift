//
//  OOTDClothesTypeView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/17.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ClothesTypeBtSelectedDelegate : class{
    func btClicked(viewTag: Int)
}

class OOTDClothesTypeView: UIView {
    
    private var iconLogoButton: UIButton!
    private var iconLogoView: UIImageView!
    private var lebelBgView: UIView!
    private var clothesTypeLabel: UILabel!
    private var clothesNumberLabel: UILabel!
    private var x: CGFloat
    private var y: CGFloat
    private var width: CGFloat
    private var height: CGFloat
    private var labelBgWidth: CGFloat
    
    private var viewTag: Int = 0
    private weak var clothesTypeBtSelectedDelegate:  ClothesTypeBtSelectedDelegate?
    
    init(frame: CGRect, labelBgWidth: CGFloat, delegate: ClothesTypeBtSelectedDelegate, tag : Int ) {
        self.labelBgWidth = labelBgWidth
        x = frame.origin.x
        y = frame.origin.y
        width = frame.width
        height = frame.width
        viewTag = tag
        self.clothesTypeBtSelectedDelegate = delegate
        super.init(frame:frame)
        
        self.backgroundColor = OOTDConstant.darkBgColor.withAlphaComponent(0.5)
        //        self.layer.borderColor = OOTDConstant.white.cgColor
        //        self.layer.borderWidth = 3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 30
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 15
        
        iconLogoButton = UIButton()
        iconLogoButton.isSelected = false
        iconLogoButton.layer.borderColor = OOTDConstant.darkBgColor.cgColor.copy(alpha: 0.3)
        iconLogoButton.layer.borderWidth = 3
        iconLogoButton.layer.cornerRadius = 30
        iconLogoButton.addTarget(self, action: #selector(self.iconLogoViewnClicked(_:)), for: .touchUpInside)
        self.addSubview(iconLogoButton)
        iconLogoButton.easy.layout([Left(0), CenterY(0), Height(60), Width(60)])
        
        iconLogoView = UIImageView()
        iconLogoButton.addSubview(iconLogoView)
        iconLogoView.easy.layout([CenterX(0), CenterY(0), Height(30), Width(30)])
        
        lebelBgView = UIView()
        addSubview(lebelBgView)
        //toolBarHightLight.backgroundColor = GMConstant.cloudColor
        lebelBgView.easy.layout([Top(0), Right(0), Bottom(0), Width(self.labelBgWidth)])
        lebelBgView.isHidden = true
        
        clothesTypeLabel = UILabel()
        clothesTypeLabel.textColor = OOTDConstant.white
        clothesTypeLabel.font = OOTDConstant.fontNormal
        lebelBgView.addSubview(clothesTypeLabel)
        //toolBarHightLight.backgroundColor = GMConstant.cloudColor
        clothesTypeLabel.easy.layout([Top(12), Left(10), Right(0), Height(20)])
        
        let clothesLabel = UILabel()
        clothesLabel.textColor = OOTDConstant.white
        clothesLabel.text = "No."
        clothesLabel.font = OOTDConstant.fontSmall
        lebelBgView.addSubview(clothesLabel)
        clothesLabel.easy.layout([Bottom(15), Left(10), Width(30), Height(12)])
        
        clothesNumberLabel = UILabel()
        clothesNumberLabel.textColor = OOTDConstant.white
        lebelBgView.addSubview(clothesNumberLabel)
        //toolBarHightLight.backgroundColor = GMConstant.cloudColor
        clothesNumberLabel.easy.layout([Bottom(15), Left(0).to(clothesLabel), Width(30), Height(15)])
        print(self.frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateClothesTypeView(iconLogo: UIImage, clotherType: String, clotherNumber: Int ){
        iconLogoView.image = iconLogo
        clothesTypeLabel.text = clotherType
        clothesNumberLabel.text = String(clotherNumber)
    }
    
    @objc func iconLogoViewnClicked(_ sender: UIButton){
        self.clothesTypeBtSelectedDelegate?.btClicked(viewTag: viewTag)
        if iconLogoButton.isSelected == false{
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [.curveEaseInOut , .allowUserInteraction],
                           animations: {
                            sender.transform = CGAffineTransform(rotationAngle: .pi)
            },
                           completion: { finished in
                            print("Bug faced right!")
            })
            //        UIView.animate(withDuration: 0.5,
            //                       delay: 0.5,
            //                       options: [.curveEaseInOut , .allowUserInteraction],
            //                       animations: {
            //                        sender.transform = CGAffineTransform(translationX: 40, y: 0)
            //                        sender.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
            //        },
            //                       completion: { finished in
            //                        print("Bug faced right!")
            //        })
            
            lebelBgView.isHidden = false
            let transition:CATransition = CATransition()
            transition.duration = 0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromLeft
            self.layer.add(transition, forKey: kCATransition)
            self.frame = CGRect(x: x, y: y, width: width + labelBgWidth, height: height)
            sender.isSelected = true
            print(self.frame)
        }else {
            updateFrame()
        }
        
    }
    
    func updateFrame(){
        if iconLogoButton.isSelected == true{
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [.curveEaseInOut , .allowUserInteraction],
                           animations: {
                            self.iconLogoButton.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
            },
                           completion: { finished in
                            print("Bug faced right!")
            })
            lebelBgView.isHidden = true
            let transition:CATransition = CATransition()
            transition.duration = 1.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromRight
            self.layer.add(transition, forKey: kCATransition)
            self.frame = CGRect(x: x, y: y, width: width, height: height)
            iconLogoButton.isSelected = false
        }
    }
}




//animateCircle(with: circlePath)
//    private func animateCircle(with path: CGPath) {
//        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
//        caframeAnimation.path = path
//        caframeAnimation.duration = 0.4
//        caframeAnimation.fillMode = .both
//        caframeAnimation.isRemovedOnCompletion = false
//        iconLogoView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey")
//
//        lebelBgView.isHidden = false
//
//        self.frame = CGRect(x: x, y: y, width: 140, height: height)
//    }
//
//    var circlePath: CGPath {
//        let startPoint_X = CGFloat(25)
//        let endPoint_X = CGFloat(115)
//        let y = CGFloat(30)
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: startPoint_X, y: y))
//        path.addLine(to: CGPoint(x: endPoint_X, y: y))
//        return path.cgPath
//    }
//

