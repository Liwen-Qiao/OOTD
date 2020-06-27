//
//  QUploadImageView.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class QUploadImageView: UIImagePickerController {
    
    private var iconImageView: UIImageView!
    private var isChanged: Bool = false
    
    init(isChanged: Bool) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoView = UIView()
        let logoImageView = UIImageView()
        if isChanged == false{
            logoImageView.image = #imageLiteral(resourceName: "Logo")}
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
        if isChanged == true{
            logoImageView.image = #imageLiteral(resourceName: "addButton")
            logoImageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            logoImageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        pickPhoto()
    }
    
    @objc func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.takePhotoWithCamera()
        })
        alert.addAction(actPhoto)
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            self.choosePhotoFromLibrary()
        })
        alert.addAction(actLibrary)
        present(alert, animated: true, completion: nil)
    }
    
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension QUploadImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickinOOTDediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        //self.imagePreview.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
