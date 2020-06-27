//
//  OOTDWearMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

protocol WearMainPageDelegate: class {
    func pushToWearMainPage(wearRealmModel: WearRealmModel)
}

class OOTDWearMainPage: UIViewController{
    
    private var wearColcView: OOTDWearColcView!
    private var wearList: [WearRealmModel]? = []
    
    private var wearMainPageDelegate: WearMainPageDelegate?
    
    init(wearMainPageDelegate: WearMainPageDelegate) {
        self.wearMainPageDelegate = wearMainPageDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        bg.image = #imageLiteral(resourceName: "oneTypeClosetBg")
        bg.contentMode = .scaleAspectFill
        bg.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(bg)
        bg.easy.layout([Edges(0)])
        
        setupClothesColcView()
    }
    
    func setupClothesColcView(){
        wearColcView = OOTDWearColcView(frame: CGRect.zero, wearList: wearList ?? [])
        wearColcView.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.2)
        self.view.addSubview(wearColcView)
        wearColcView.easy.layout([Edges(10)])
    }
    
    @objc func addButtonClicked(){
        let realm = try! Realm()
        try! realm.write {
            let newWearRealmModel = WearRealmModel(value: ["wearType": 0, "wearSubType": 0, "wearMainImage": "wearFolder", "wearMainImageType": "\(OOTDConstant.getTimeString()).png" ])
            realm.add(newWearRealmModel, update: .modified)
            self.wearMainPageDelegate?.pushToWearMainPage(wearRealmModel: newWearRealmModel)
        }
        
    }
}
