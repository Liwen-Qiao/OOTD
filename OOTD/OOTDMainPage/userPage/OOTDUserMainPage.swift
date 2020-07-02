//
//  OOTDUserMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

class OOTDUserMainPage: UIViewController{
    
    private var userSettingTableView: UITableView!
    private var wearListLabelNum:  UILabel!
    private var clothesListLabelNum:  UILabel!
    
    private var settingItemList: [String] = ["数据备份", "推荐给朋友", "好评鼓励","问题反馈","关于我们"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Me"
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        
        setupTitleView()
        
        setupTableView()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        let theWearList = realm.objects(WearRealmModel.self)
        wearListLabelNum.text = "\(Int(theWearList.count))"
        
        let theClothesList = realm.objects(ClothesRealmModel.self)
        clothesListLabelNum.text = "\(Int(theClothesList.count))"
    }
    
    
    
    func setupTitleView(){
        let userTitleView = OOTDUserTitleView()
        userTitleView.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        userTitleView.layer.shadowColor = UIColor.darkGray.cgColor
        userTitleView.layer.cornerRadius = 15
        self.view.addSubview(userTitleView)
        userTitleView.easy.layout(Left(10), Right(10),Top(10), Height(270))
        
        let logoView = QLogoView(frame: CGRect.zero, isChanged: true)
        logoView.updateIconImageView(IconImage: #imageLiteral(resourceName: "addIcon"))
        userTitleView.addSubview(logoView)
        logoView.easy.layout(CenterX(0), Width(100), Height(100), Top(40))
        
        let wearBg = UIView()
        wearBg.layer.cornerRadius = 15
        userTitleView.addSubview(wearBg)
        wearBg.easy.layout(Width(200), Height(70), Top(20).to(logoView),Left(0))
        
        let wearListImageView = UIImageView()
        wearListImageView.image = #imageLiteral(resourceName: "wearSelectedIcon")
        wearListImageView.layer.cornerRadius = 15
        wearBg.addSubview(wearListImageView)
        wearListImageView.easy.layout(Width(40), Height(40), Top(0), CenterX(0))
        
        wearListLabelNum = UILabel()
        wearListLabelNum.text = "0"
        wearListLabelNum.textAlignment = .center
        wearListLabelNum.textColor = OOTDConstant.darkBgColor
        wearBg.addSubview(wearListLabelNum)
        wearListLabelNum.easy.layout(Left(30), Right(30), Bottom(0), CenterX(0))
        
        let closetBg = UIView()
        closetBg.layer.cornerRadius = 15
        userTitleView.addSubview(closetBg)
        closetBg.easy.layout(Width(200), Height(70), Top(20).to(logoView),Right(0))
        
        let closetListImageView = UIImageView()
        closetListImageView.image = #imageLiteral(resourceName: "closetSelectedIcon")
        closetListImageView.layer.cornerRadius = 15
        closetBg.addSubview(closetListImageView)
        closetListImageView.easy.layout(Width(40), Height(40), Top(0), CenterX(0))
        
        clothesListLabelNum = UILabel()
        clothesListLabelNum.text = "0"
        clothesListLabelNum.textAlignment = .center
        clothesListLabelNum.textColor = OOTDConstant.darkBgColor
        closetBg.addSubview(clothesListLabelNum)
        clothesListLabelNum.easy.layout(Left(30), Right(30), Bottom(0), CenterX(0))
    }
    
    func setupTableView(){
        let userSettingTableViewBg = UIView()
        userSettingTableViewBg.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        userSettingTableViewBg.layer.shadowColor = OOTDConstant.darkUniversalColor.cgColor
        userSettingTableViewBg.layer.cornerRadius = 15
        userSettingTableViewBg.layer.shadowOpacity = 0.9
        userSettingTableViewBg.layer.shadowOffset = CGSize(width: 5, height: 5)
        userSettingTableViewBg.layer.shadowRadius = 15
        self.view.addSubview(userSettingTableViewBg)
        userSettingTableViewBg.easy.layout(Left(10), Right(10),Top(285), Bottom(15))
        
        userSettingTableView = UITableView()
        userSettingTableView.backgroundColor = .clear
        //userSettingTableView.tintColor = OOTDConstant.cloudColor
        userSettingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "userSettingTableViewCell")
        userSettingTableView.delegate = self
        userSettingTableView.dataSource = self
        userSettingTableViewBg.addSubview(userSettingTableView)
        userSettingTableView.easy.layout(Left(10), Right(10), Top(20), Bottom(20))
    }
    
}
extension OOTDUserMainPage: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSettingTableViewCell", for: indexPath)
        cell.textLabel?.text = settingItemList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "ChineseFontRegular", size: 14)
        cell.textLabel?.textColor = OOTDConstant.darkBgColor
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = OOTDConstant.white.withAlphaComponent(0.8)
        cell.layer.cornerRadius = 15
        cell.tintColor = OOTDConstant.universalColor
        let bgView = UIView(frame: cell.frame)
        bgView.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.2)
        cell.clipsToBounds = true
        cell.selectedBackgroundView = bgView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.userSettingTableView.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 4{
            let aboutUsPage = OOTDUserAboutUsPage()
            //let closetMianView = OOTDOneTypeClothesMainPage(oneTypeClothesList: [self.clothesList[selectedViewTag]])
            self.navigationController?.pushViewController(aboutUsPage, animated: true)
        }
    }
}
