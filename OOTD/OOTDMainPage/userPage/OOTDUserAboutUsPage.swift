//
//  OOTDUserAboutUsPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/21.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class OOTDUserAboutUsPage: UIViewController {
    
    private var aboutUsTableView: UITableView!
    
    private var aboutusItemList: [String] = ["公司官网","关注微信公众号","商业合作","打赏程序员小姐姐"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        
        let titleView = UIView()
        titleView.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        titleView.layer.shadowColor = UIColor.darkGray.cgColor
        titleView.layer.cornerRadius = 15
//        titleView.layer.shadowOpacity = 0.5
//        titleView.layer.shadowOffset = CGSize(width: 5, height: 5)
//        titleView.layer.shadowRadius = 15
        self.view.addSubview(titleView)
        titleView.easy.layout(Left(10), Right(10),Top(10), Height(270))
        
        let logoView = QLogoView(frame: CGRect.zero, isChanged: false)
        logoView.updateIconImageView(IconImage: #imageLiteral(resourceName: "HighQltyLogo"))
        titleView.addSubview(logoView)
        logoView.easy.layout(CenterX(0), Width(100), Height(100), Top(40))
        
        let companyNameLabel = UILabel()
        companyNameLabel.text = "上海海乔信息技术有限公司"
        companyNameLabel.font = UIFont(name: "REEJICutieTRegular", size: 14)
        companyNameLabel.textAlignment = .center
        companyNameLabel.textColor = OOTDConstant.darkBgColor
        titleView.addSubview(companyNameLabel)
        companyNameLabel.easy.layout(CenterX(0), Width(250), Height(15), Top(20).to(logoView))
        
        
        let companyEngNameLabel = UILabel()
        companyEngNameLabel.text = "Shanghai HighQlty Information Tecnology Ltd"
        companyEngNameLabel.font = UIFont(name: "companyEngNameLabel-TTF-2", size: 24)
        companyEngNameLabel.textAlignment = .center
        companyEngNameLabel.textColor = OOTDConstant.darkBgColor
        companyEngNameLabel.font = OOTDConstant.fontSmall
        titleView.addSubview(companyEngNameLabel)
        companyEngNameLabel.easy.layout(CenterX(0), Width(UIScreen.main.bounds.width), Height(15), Top(20).to(companyNameLabel))
        
        let aboutUsTableViewBg = UIView()
        aboutUsTableViewBg.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.7)
        aboutUsTableViewBg.layer.shadowColor = OOTDConstant.darkUniversalColor.cgColor
        aboutUsTableViewBg.layer.cornerRadius = 15
        aboutUsTableViewBg.layer.shadowOpacity = 0.2
        aboutUsTableViewBg.layer.shadowOffset = CGSize(width: 5, height: 5)
        aboutUsTableViewBg.layer.shadowRadius = 15
        self.view.addSubview(aboutUsTableViewBg)
        aboutUsTableViewBg.easy.layout(Left(10), Right(10),Top(15).to(titleView), Bottom(15))
        
        aboutUsTableView = UITableView()
        aboutUsTableView.backgroundColor = .clear
        aboutUsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "userAboutUsTableViewCell")
        aboutUsTableView.delegate = self
        aboutUsTableView.dataSource = self
        //aboutUsTableView.separatorColor = .clear
        aboutUsTableView.separatorStyle = .singleLine
        aboutUsTableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        aboutUsTableViewBg.addSubview(aboutUsTableView)
        aboutUsTableView.easy.layout(Left(10), Right(10),Top(20), Bottom(40))
        
    }
    
}
extension OOTDUserAboutUsPage: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userAboutUsTableViewCell", for: indexPath)
        cell.textLabel?.text = aboutusItemList[indexPath.row]
        cell.textLabel?.font = OOTDConstant.fontNormal
        cell.textLabel?.textColor = OOTDConstant.darkBgColor
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = OOTDConstant.white.withAlphaComponent(0.8)
        cell.layer.cornerRadius = 15
        let bgView = UIView(frame: cell.frame)
        bgView.backgroundColor = OOTDConstant.universalColor.withAlphaComponent(0.2)
        cell.clipsToBounds = true
        cell.selectedBackgroundView = bgView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.aboutUsTableView.frame.height/4
    }
    
}
