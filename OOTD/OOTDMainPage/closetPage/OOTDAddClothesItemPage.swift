//
//  OOTDAddClothesItemPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/24.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//


import UIKit
import EasyPeasy
import RealmSwift

class OOTDAddClothesItemPage: UIViewController{
    
    //ui
    private var itemImageView: QLogoView!
    private var detailTableView: UITableView!
    
   // private weak var addItemDelegate: QAddItemDelegate?
    
    //    init(addItemDelegate: QAddItemDelegate) {
    //        self.addItemDelegate = addItemDelegate
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        navigationController?.navigationBar.barTintColor = OOTDConstant.universalColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        
        let button = UIButton()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.alpha = 0.7
        button.setImage(#imageLiteral(resourceName: "saveItem"), for: .normal)
        let saveButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        saveButton.customView = button
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        button.easy.layout(Left(0),Right(0), Width(40), Height(30))
        navigationItem.setRightBarButton(saveButton, animated: false)
        
        setupBackView()
        
        setupItemDetailView()
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
    
    func setupItemDetailView(){
        
        let shadowView = UIView()
        shadowView.contentMode = .scaleToFill
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.shadowRadius = 15
        shadowView.layer.cornerRadius = 15
        shadowView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.view.addSubview(shadowView)
        shadowView.easy.layout([Top(UIScreen.main.bounds.height*0.03), Right(25),Left(25),Bottom(UIScreen.main.bounds.height*0.03)])
        
        let itemImageBgView = UIView()
        shadowView.addSubview(itemImageBgView)
        itemImageBgView.easy.layout([Left(25), Right(25), Height(240), Top(30)])
        
        let itemImageLabel = UILabel()
        itemImageLabel.text = "Item Image:"
        itemImageLabel.font = UIFont(name: "MavenProRegular", size: OOTDConstant.fontTitle.pointSize)
        itemImageLabel.textColor = .black
        itemImageLabel.contentMode = .bottom
        itemImageLabel.sizeToFit()
        itemImageBgView.addSubview(itemImageLabel)
        itemImageLabel.easy.layout([Left(10), Right(0), Height(20), Top(0)])
        
        itemImageView = QLogoView(frame: CGRect.zero, isChanged: true)
        itemImageView.updateIconImageView(IconImage: #imageLiteral(resourceName: "addItemPhoto"))
        itemImageBgView.addSubview(itemImageView)
        itemImageView.easy.layout(Width(200), Right(20), Top(15).to(itemImageLabel), Height(200))
        itemImageView.isUserInteractionEnabled = true
        addTapGesture(view: itemImageView)
        
    }
    
    @objc func saveButtonClicked() {
        let realm = try! Realm()
        try! realm.write {
            let newClothesModel = ClothesRealmModel(value: ["clothesType": 0, "clothesSubType": 0, "clothesMainImageType": "clothesFolder", "clothesMainImage": "\(OOTDConstant.getTimeString()).png" ])
            realm.add(newClothesModel, update: .modified)
            QImageFile.saveImageByNameAndLocation(image: itemImageView.getIconImageViewImage(), name: newClothesModel.clothesMainImage, location: newClothesModel.clothesMainImageType)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func addTapGesture(view: UIView) {
        let pan = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    //选取图片
    @objc func handleTap(sender: UITapGestureRecognizer) {
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

extension OOTDAddClothesItemPage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.itemImageView.updateIconImageView(IconImage: image!)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
