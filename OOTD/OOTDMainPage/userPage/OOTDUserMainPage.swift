//
//  OOTDUserMainPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDUserMainPage: UIViewController{
    
    private var userSettingTableView: UITableView!
    
    private var settingItemList: [String] = ["数据备份", "推荐给朋友", "好评鼓励","问题反馈","关于我们"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        
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
        
        let userSettingTableViewBg = UIView()
        userSettingTableViewBg.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        userSettingTableViewBg.layer.shadowColor = OOTDConstant.darkUniversalColor.cgColor
        userSettingTableViewBg.layer.cornerRadius = 15
        userSettingTableViewBg.layer.shadowOpacity = 0.9
        userSettingTableViewBg.layer.shadowOffset = CGSize(width: 5, height: 5)
        userSettingTableViewBg.layer.shadowRadius = 15
        self.view.addSubview(userSettingTableViewBg)
        userSettingTableViewBg.easy.layout(Left(10), Right(10),Top(15).to(userTitleView), Bottom(15))
        
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
        cell.textLabel?.font = OOTDConstant.fontNormal
        cell.accessoryType = .disclosureIndicator
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
