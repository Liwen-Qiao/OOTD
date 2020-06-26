//
//  OOTDEditWearPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDEditWearPage: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let saveBt = UIButton()
        saveBt.layer.cornerRadius = 0.5 * saveBt.bounds.size.width
        saveBt.alpha = 0.7
        saveBt.setImage(#imageLiteral(resourceName: "saveItem"), for: .normal)
        let rightbutton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        rightbutton.customView = saveBt
        saveBt.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        saveBt.easy.layout(Left(0),Right(0), Width(40), Height(30))
        navigationItem.setRightBarButton(rightbutton, animated: false)
        
        let leftBt = UIButton()
        leftBt.layer.cornerRadius = 0.5 * leftBt.bounds.size.width
        leftBt.alpha = 0.7
        leftBt.setImage(#imageLiteral(resourceName: "saveItem"), for: .normal)
        let leftbutton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        leftbutton.customView = leftBt
        leftBt.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        leftBt.easy.layout(Left(0),Right(0), Width(40), Height(30))
        navigationItem.setLeftBarButton(leftbutton, animated: false)
        
        setupBackView()
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
    
    @objc func saveButtonClicked(){
//        let destination = QMainTabView()
//        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
//        let editWearNaviPage = UINavigationController(rootViewController: destination)
//        sceneDelegate.window!.rootViewController = editWearNaviPage
    }
    
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: false)
        }
}
