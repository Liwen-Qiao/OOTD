//
//  QTextInputWithLabelField.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

class QTextInputWithLabelField: UIView, UITextFieldDelegate {
    
    var textField : QTextInputView!
    
    init(frame: CGRect, bacgroundColor: UIColor, textFieldHeight: CGFloat, textContent: String,
         placeHolder: String, textColor: UIColor, textFont: UIFont, padding: CGFloat) {
        
        super.init(frame: frame)
        self.backgroundColor = bacgroundColor
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.contentMode = .scaleToFill
        stackView.alpha = 1
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.easy.layout([Left(padding), Right(padding), Top(0), Bottom(0)])
        
        let label = UILabel()
        label.text = textContent
        label.font = UIFont(name: "MavenProRegular", size: textFont.pointSize)
        label.textColor = textColor
        label.contentMode = .bottom
        label.sizeToFit()
        stackView.addSubview(label)
        label.easy.layout([Left(0), Right(0), Height(20), Top(0)])
         
        textField = QTextInputView(frame: CGRect.zero, bacgroundColor: bacgroundColor, viewHeight: textFieldHeight, textContent: "", placeHolder: placeHolder, textWidth: 0, textColor: .clear, textFont: OOTDConstant.fontNormal, padding: 0)
        stackView.addSubview(textField)
        textField.easy.layout([Left(0), Right(0), Top(0).to(label), Height(textFieldHeight)])
        
        
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

    func getTextInputFieldText() -> String{
        return textField.getTextInputFieldText()
    }
    
}


