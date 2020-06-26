//
//  QLoginPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy
import RealmSwift

class QLoginPage: UIViewController{
    
    private var emailView: QTextInputWithLabelField!
    private var pwView: QTextInputWithLabelField!
    
    private weak var loginMethod: QLoginMethod?
    
    // main ctrl
    private var loginButton : UIButton!
    private var loginInAsQiaoButton : UIButton!
    
    // data
    let baseUrl = "http://umaexpress.ca:3008"

    
    // MARK: - /*--------- life cycle method ---------*/
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        self.navigationController?.navigationBar.isHidden = true
        
//        let realm = try! Realm()
//        print(realm.configuration.fileURL)
        
        self.loginMethod = self
        
        setupLogoView()
   
        setupBackView()
        
        setupInputView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    func setupLogoView(){
        let logoView = UIView()
        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "appicon")
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 40
        logoView.layer.shadowColor = UIColor.darkGray.cgColor
        logoView.layer.cornerRadius = 40
        logoView.layer.shadowOpacity = 0.5
        logoView.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoView.layer.shadowRadius = 15
        logoView.addSubview(logoImageView)
        logoImageView.easy.layout(Edges(0))
        self.view.addSubview(logoView)
        logoView.easy.layout([Left(40),Top(80),Width(80),Height(80)])
    }
    
    func setupBackView(){
        let imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "LoginBg")
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        imageView.easy.layout([Edges(0)])

    }
    
    func setupInputView(){
        
        let shadowView = UIView()
        shadowView.contentMode = .scaleToFill
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.shadowRadius = 15
        shadowView.layer.cornerRadius = 15
        shadowView.backgroundColor = .white
        self.view.addSubview(shadowView)
        shadowView.easy.layout([Top(UIScreen.main.bounds.height/2.8), Width(425),Left(40), Bottom(UIScreen.main.bounds.height*0.15)])
        
        let continueLabel = UILabel()
        continueLabel.text = "Login to Continue.."
        continueLabel.textColor = .black
        continueLabel.contentMode = .left
        continueLabel.font = UIFont(name: "MavenProRegular", size: 24)
        view.addSubview(continueLabel)
        continueLabel.easy.layout([Left(40),Height(30),Bottom(8).to(shadowView)])
        
        emailView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Email", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(emailView)
        emailView.easy.layout([Left(34), Width(380), Height(UIScreen.main.bounds.height*0.1), Top(UIScreen.main.bounds.height*0.05)])
        
        pwView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Passward", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(pwView)
        pwView.easy.layout([Left(34), Width(380), Height(UIScreen.main.bounds.height*0.1), Top(UIScreen.main.bounds.height*0.022).to(emailView)])
        

        //LoginInButton
        
        let lgStackView = UIStackView()
        lgStackView.axis = .vertical
        lgStackView.contentMode = .scaleToFill
        lgStackView.alpha = 1
        lgStackView.spacing = 6
        lgStackView.alignment = .fill
        lgStackView.distribution = .fill
        shadowView.addSubview(lgStackView)
        lgStackView.easy.layout([Left(34), Width(380), Height(80), Bottom(UIScreen.main.bounds.height*0.1)])
        
        
        let forgetPwButton = UIButton()
        forgetPwButton.backgroundColor = .clear
        forgetPwButton.setTitle("Forgot Password?", for: .normal)
        forgetPwButton.setTitleColor(.gray, for: .highlighted)
        forgetPwButton.titleLabel?.font = UIFont(name: "MavenProRegular", size: OOTDConstant.fontTitle.pointSize)
        forgetPwButton.titleLabel?.textAlignment = .left
        forgetPwButton.setTitleColor(OOTDConstant.customColor, for: .normal)
        lgStackView.addSubview(forgetPwButton)
        forgetPwButton.easy.layout([Left(15), Width(150),Height(20), Top(0)])
        forgetPwButton.addTarget(self, action: #selector(forgotPw), for: .touchUpInside)
        
        let loginInButton = UIButton()
        loginInButton.backgroundColor = OOTDConstant.universalColor
        loginInButton.setTitle("LOGIN", for: .normal)
        loginInButton.setTitleColor(.gray, for: .highlighted)
        loginInButton.setTitleColor(.black, for: .normal)
        loginInButton.layer.cornerRadius = 10
        loginInButton.titleLabel?.font = UIFont(name: "MavenProbold", size: OOTDConstant.fontTitle.pointSize)
        lgStackView.addSubview(loginInButton)
        loginInButton.easy.layout([Left(15),Top(9).to(forgetPwButton),Width(UIScreen.main.bounds.width - 38), Height(UIScreen.main.bounds.height*0.07)])
        loginInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.contentMode = .scaleToFill
        stackView.alpha = 1
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fill
        shadowView.addSubview(stackView)
        stackView.easy.layout([Left(50),Right(65),Height(33),Bottom(UIScreen.main.bounds.height*0.025)])
        
        let newLabel = UILabel()
        newLabel.text = "New?"
        newLabel.font = UIFont.init(name: "MavenProRegular", size: OOTDConstant.fontTitle.pointSize)
        newLabel.textColor = .black
        newLabel.contentMode = .bottom
        stackView.addSubview(newLabel)
        newLabel.easy.layout([Top(0), Width(50), Left(0), Bottom(0)])
        
        let accountLabel = UILabel()
        accountLabel.text = "for a new account."
        accountLabel.font = UIFont(name: "MavenProRegular", size: OOTDConstant.fontTitle.pointSize)
        accountLabel.contentMode = .bottom
        accountLabel.textColor = .black
        accountLabel.sizeToFit()
        stackView.addSubview(accountLabel)
        accountLabel.easy.layout([Top(0),Right(0),Bottom(0)])
        
        let signUpBt = UIButton()
        signUpBt.setTitle("Sign-up", for: .normal)
        signUpBt.setTitleColor(OOTDConstant.universalColor, for: .normal)
        signUpBt.setTitleColor(OOTDConstant.customColor, for: .highlighted)
        signUpBt.titleLabel?.font = UIFont(name: "MavenProBold", size: OOTDConstant.fontTitle.pointSize)
        signUpBt.titleLabel?.contentMode = .bottom
        stackView.addSubview(signUpBt)
        signUpBt.easy.layout([Top(0), Right(10).to(accountLabel), Left(0).to(newLabel),Bottom(0)])
        signUpBt.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
    }
    
    
    @objc func logIn() {
        let email = emailView.getTextInputFieldText()
        let pw = pwView.getTextInputFieldText()
        guard email != "" else { print("请输入邮箱"); return }
        guard pw != "" else { print("请输入密码"); return }
        loginMethod?.login(email: email, pw: pw)
       
    }   
    
    @objc func SignUp() {
        self.navigationController?.pushViewController(QSignUpPage(), animated: true)
    }
    
    
    @objc func forgotPw() {
        
    }
    
}

extension QLoginPage: QLoginMethod{
    func successLogin(page: QMainTabView) {
        self.navigationController?.pushViewController(page, animated: true)
    }
}
