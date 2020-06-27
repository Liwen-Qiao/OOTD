//
//  QSignUpPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import RealmSwift
import EasyPeasy

class QSignUpPage: UIViewController{
    //ui
    private var emailView: QTextInputWithLabelField!
    private var phoneNoView: QTextInputWithLabelField!
    private var pwView: QTextInputWithLabelField!
    private var pwConfirmView: QTextInputWithLabelField!
    private var restaurantNameView: QTextInputWithLabelField!
    private let textFiledHeight = UIScreen.main.bounds.height*0.08
    
    private var originY: CGFloat = 0
    private var editingText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackView()
        
        setupTitleView()
        
        setupInputView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardinfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        // 获得软键盘的高
        let keyboardheight: CGFloat = (keyboardinfo as AnyObject).cgRectValue.size.height
        
        //计算输入框和软键盘的高度差
        self.originY = self.view.frame.origin.y
        print("originY\(originY)")
        let rect = self.editingText!.convert(self.editingText!.bounds, to: self.view)
        print("rect\(rect)")
        let y = self.view.bounds.height - rect.origin.y - self.editingText!.bounds.height - keyboardheight
        print("y\(y)")
        UIView.animate(withDuration: 0.5) {
            if y < 0 {
                self.view.frame.origin.y = (self.originY + y)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //        if self.view.frame.origin.y != 0{
        //            self.view.frame.origin.y = 0
        //        }
        //软键盘收起的时候恢复原始偏移
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
        
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
    
    func setupTitleView(){
        let backBt = UIButton()
        backBt.backgroundColor = .clear
        backBt.setImage(#imageLiteral(resourceName: "backBt-signIn"), for: .normal)
        backBt.setTitleColor(OOTDConstant.customColor, for: .highlighted)
        backBt.setTitleColor(OOTDConstant.universalColor, for: .normal)
        backBt.layer.cornerRadius = 10
        backBt.titleLabel?.font = UIFont(name: "MavenProbold", size: OOTDConstant.fontTitle.pointSize)
        view.addSubview(backBt)
        backBt.easy.layout([Left(25), Height(35), Width(35),Top(40)])
        backBt.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        let signupLabel = UILabel()
        signupLabel.text = "Sign Up"
        signupLabel.font = UIFont.init(name: "MavenProBlack", size: 30)
        signupLabel.textColor = OOTDConstant.darkBgColor
        signupLabel.textAlignment = .center
        signupLabel.sizeToFit()
        self.view.addSubview(signupLabel)
        signupLabel.easy.layout([Top(UIScreen.main.bounds.height*0.1), Width(200),Height(UIScreen.main.bounds.height*0.06), CenterX(-10)])
        
        let accountLabel = UILabel()
        accountLabel.text = "Create a new account."
        accountLabel.font = UIFont(name: "MavenProRegular", size: OOTDConstant.fontTitle.pointSize)
        accountLabel.textAlignment = .center
        accountLabel.textColor = OOTDConstant.universalColor
        accountLabel.sizeToFit()
        self.view.addSubview(accountLabel)
        accountLabel.easy.layout([Top(0).to(signupLabel),Width(250),Height(30),  CenterX(0),])
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
        shadowView.easy.layout([Top(UIScreen.main.bounds.height*0.23), Right(25),Left(25),Bottom(UIScreen.main.bounds.height*0.15)])
        
        emailView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Email", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(emailView)
        emailView.easy.layout([Left(25), Right(25), Height(textFiledHeight), Top(30)])
        
        phoneNoView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Phone Number", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(phoneNoView)
        phoneNoView.easy.layout([Left(25), Right(25), Height(textFiledHeight), Top(20).to(emailView)])
        
        pwView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Passward", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(pwView)
        pwView.easy.layout([Left(25), Right(25), Height(textFiledHeight), Top(20).to(phoneNoView)])
        
        pwConfirmView = QTextInputWithLabelField(frame: CGRect.zero, bacgroundColor: .clear, textFieldHeight: UIScreen.main.bounds.height*0.08, textContent: "Confirm Passward", placeHolder: "", textColor: .black, textFont: OOTDConstant.fontTitle, padding: 10)
        shadowView.addSubview(pwConfirmView)
        pwConfirmView.easy.layout([Left(25), Right(25), Height(textFiledHeight), Top(20).to(pwView)])
        
        //LoginInButton
        let loginInButton = UIButton()
        loginInButton.backgroundColor = OOTDConstant.universalColor
        loginInButton.setTitle("CREAT ACCOUNT AND LOGIN", for: .normal)
        loginInButton.setTitleColor(.gray, for: .highlighted)
        loginInButton.setTitleColor(.black, for: .normal)
        loginInButton.layer.cornerRadius = 10
        loginInButton.titleLabel?.font = UIFont(name: "MavenProbold", size: OOTDConstant.fontTitle.pointSize)
        shadowView.addSubview(loginInButton)
        loginInButton.easy.layout([Left(35),Top(30).to(pwConfirmView),Right(35), Height(UIScreen.main.bounds.height*0.08)])
        loginInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        emailView.textField.textInputField.delegate = self
        phoneNoView.textField.textInputField.delegate = self
        pwView.textField.textInputField.delegate = self
        pwConfirmView.textField.textInputField.delegate = self
    }
    
    
    @objc func logIn() {
        let emailAdd = emailView.getTextInputFieldText()
        let phoneNo = phoneNoView.getTextInputFieldText()
        let pw = pwView.getTextInputFieldText()
        print(pw)
        let pwConfirm = pwConfirmView.getTextInputFieldText()
        print(pwConfirm)
        guard emailAdd != "" else { print("请输入邮箱"); return }
        guard phoneNo != "" else { print("请输入电话号"); return }
        guard pw != "" else { print("请输入密码"); return }
        guard pwConfirm != "" else { print("请再次输入密码"); return }
        guard pw == pwConfirm else { print("密码不一致"); return }
        
        // Get the default Realm
        let realm = try! Realm()
        try! realm.write {
            let newUserRealmModel = UserRealmModel(value: ["userId": emailAdd, "userEmail": emailAdd, "userPhoneNumber": Int(phoneNo) ?? 0, "userPw": pw ])
            realm.add(newUserRealmModel, update: .modified)
        }
        let userPage = QLoginPage()
        self.navigationController?.pushViewController(userPage, animated: true)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension QSignUpPage: UITextFieldDelegate {
    //设置点击软键盘return键隐藏软键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //获得正在输入的UITextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingText = textField
    }
}
