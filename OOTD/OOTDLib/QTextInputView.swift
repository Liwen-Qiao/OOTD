//
//  QTextInputView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class QTextInputView: UIView, UITextFieldDelegate {
    
    private var textLabel: UILabel!
    var textInputField : UITextField!
        
    init(frame: CGRect, bacgroundColor: UIColor, viewHeight: CGFloat, textContent: String,
         placeHolder: String, textWidth: CGFloat, textColor: UIColor, textFont: UIFont, padding: CGFloat) {
        
        super.init(frame: frame)
        self.backgroundColor = bacgroundColor
 
        textLabel = UILabel()
        textLabel.text = textContent
        textLabel.textColor = textColor
        self.addSubview(textLabel)
        textLabel.easy.layout([Left(padding), Width(textWidth), Height(viewHeight-10), Top(5), CenterY(0)])
        
        textInputField = UITextField(frame:CGRect())
        textInputField.backgroundColor = .white
        textInputField.textAlignment = .left
        textInputField.placeholder = placeHolder
        textInputField.textColor = .black
        textInputField.font = UIFont(name: "MavenProRegular", size: textFont.pointSize)
        textInputField.layer.borderWidth = 1.0
        textInputField.layer.cornerRadius = 10
        textInputField.returnKeyType = UIReturnKeyType.next
        textInputField.layer.borderColor = OOTDConstant.customColor.cgColor
        
        textInputField.delegate = self
        self.addSubview(textInputField)
        textInputField.easy.layout([Left(5).to(textLabel), Right(padding), Height(45), CenterY(0)])
        textInputField.clearButtonMode = .whileEditing
        textInputField.returnKeyType = .done
        //textInputField.becomeFirstResponder()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.textInputField.resignFirstResponder()
            return true;
        }
    
    func getTextInputFieldText() -> String{
        return textInputField.text ?? ""
    }
}
