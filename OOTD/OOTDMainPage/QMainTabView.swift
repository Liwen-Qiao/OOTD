//
//  QMainTabView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import CoreData
import SOTabBar
 
class QMainTabView: SOTabBarController{
    
    private var UserRealmModel: UserRealmModel
    
    init(UserRealmModel: UserRealmModel) {
        self.UserRealmModel = UserRealmModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        SOTabBarSetting.tabBarTintColor = .white
        SOTabBarSetting.tabBarHeight = 50
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 55, height: 55)
        SOTabBarSetting.tabBarBackground = OOTDConstant.universalColor
        SOTabBarSetting.tabBarShadowColor = OOTDConstant.cloudColor.cgColor
        SOTabBarSetting.tabBarSizeImage = 30
        
        super.viewDidLoad()
        
        //let defaults = UserDefaults.standard
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.isHidden = true
        
        //navigationController?.navigationBar.isHidden = true
        self.edgesForExtendedLayout = []
        
        let wearMainPage = OOTDWearMainPage(wearMainPageDelegate: self)
        let closetMainPage = OOTDClosetMainPage()
        let userMainPage = OOTDUserMainPage()
        
        let wearMainNavPage = UINavigationController(rootViewController: wearMainPage)
        wearMainNavPage.tabBarItem = UITabBarItem(title: "穿搭", image: UIImage(named: "wearIcon"), selectedImage: UIImage(named: "wearSelectedIcon"))
        
        let closetMainNavPage = UINavigationController(rootViewController: closetMainPage)
        closetMainNavPage.tabBarItem = UITabBarItem(title: "衣橱", image: UIImage(named: "closetIcon"), selectedImage: UIImage(named: "closetSelectedIcon"))
        
        let userMainNavPage = UINavigationController(rootViewController: userMainPage)
        userMainNavPage.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "userIcon"), selectedImage: UIImage(named: "userSelectedIcon"))

        viewControllers = [wearMainNavPage, closetMainNavPage, userMainNavPage]
  
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension QMainTabView: WearMainPageDelegate{
    func pushToWearMainPage(wearRealmModel: WearRealmModel?) {
        let destination = OOTDEditWearPage(wearRealmModel: wearRealmModel)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

////一共包含了两个视图
//let viewMain = QOrderMainPage(coreDataStack: self.coreDataStack)
//viewMain.title = "Order"
//let viewSetting = QOwnerMainPage(coreDataStack: self.coreDataStack)
//viewSetting.title = "Setting"
//
////分别声明两个视图控制器
//let main = UINavigationController(rootViewController:viewMain)
//main.tabBarItem.image = UIImage(named:"first")
//main.tabBarItem.badgeValue = "1"
//
//let setting = UINavigationController(rootViewController:viewSetting)
//setting.tabBarItem.image = UIImage(named:"userIcon")
//self.viewControllers = [main,setting]
//
////默认选中的是Order界面
//self.selectedIndex = 0
