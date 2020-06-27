//
//  OOTDLayerEditPage.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/25.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit
import EasyPeasy

protocol OOTDLayerInfoUpdateDelegate: class {
    func layerInfoUpdate(layerList: [WearClothesRealmModel] )
}

class OOTDLayerEditPage: UIView{
    
    //data
    private var wearClothesLayerList: [WearClothesRealmModel] = []
    
    //delegate
    private weak var layerInfoUpdateDelegate: OOTDLayerInfoUpdateDelegate?
    
    init(frame: CGRect, layerList: [WearClothesRealmModel], delegate: OOTDLayerInfoUpdateDelegate) {
        self.wearClothesLayerList = layerList
        self.layerInfoUpdateDelegate = delegate
        super.init(frame:frame)
        
        self.backgroundColor = .white
        self.layer.borderColor = OOTDConstant.universalColor.cgColor
        self.layer.borderWidth = 3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 30
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 15
        self.clipsToBounds = true
        
        // layerInfoTable
        setupLayerInfoTable()
        
        setupButtonView()
    }
    
    required init?(coder aDecoder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    func setupButtonView(){
        let cencelBt = UIButton()
        cencelBt.backgroundColor = .white
        cencelBt.setTitle("Cancel", for: .normal)
        cencelBt.setTitleColor(.black, for: .normal)
        cencelBt.clipsToBounds = true
        self.addSubview(cencelBt)
        cencelBt.easy.layout([Left(0), Bottom(0), Height(60), Width(150)])
        cencelBt.addTarget(self, action: #selector(cencelButtonPressed), for: .touchUpInside)
        
        let doneBt = UIButton()
        doneBt.backgroundColor = .white
        doneBt.setTitle("Done", for: .normal)
        doneBt.setTitleColor(OOTDConstant.universalColor, for: .normal)
        doneBt.clipsToBounds = true
        self.addSubview(doneBt)
        doneBt.easy.layout([Left(0).to(cencelBt), Bottom(0), Height(60), Width(150)])
        doneBt.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    //setup LayerInfoTable
    func setupLayerInfoTable(){
        let layerTable = UITableView(frame: CGRect())
        layerTable.backgroundColor = UIColor.white
        layerTable.register(OOTDLayerEditCell.self, forCellReuseIdentifier: "OOTDLayerEditCell")
        layerTable.separatorInset =  UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layerTable.dataSource = self
        layerTable.delegate = self
        layerTable.isEditing = true
        layerTable.allowsSelectionDuringEditing = true
        self.addSubview(layerTable)
        layerTable.easy.layout([Left(0), Top(0), Right(0), Bottom(0)])
    }
    
    @objc func cencelButtonPressed(){
        self.removeFromSuperview()
    }
    
    @objc func doneButtonPressed(){
        layerInfoUpdateDelegate?.layerInfoUpdate(layerList: self.wearClothesLayerList)
        
        self.removeFromSuperview()
    }
    
}

//todo: UITableViewDataSource, UITableViewDelegate 分开
extension OOTDLayerEditPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wearClothesLayerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OOTDLayerEditCell", for: indexPath) as! OOTDLayerEditCell
        let layerInfoList = wearClothesLayerList[indexPath.row]
        cell.updateLayerCell(layerWearClothes: layerInfoList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // delete table cell
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            wearClothesLayerList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // move table cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = wearClothesLayerList[sourceIndexPath.row]
        wearClothesLayerList.remove(at: sourceIndexPath.row)
        wearClothesLayerList.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

