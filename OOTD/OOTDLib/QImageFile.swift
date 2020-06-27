//
//  QImageFile.swift
//  OOTD
//
//  Created by qiaoliwen on 2020/6/16.
//  Copyright © 2020 qiaoliwen. All rights reserved.
//

import UIKit

struct QImageFile {
    
    static func createFileDirPath(pathLabel: String) -> URL {
        let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(pathLabel)
        do {
            if FileManager.default.fileExists(atPath: dataPath.path) == false{
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                print("folder created")
            }else{
                print("folder exist")
            }
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        return dataPath
    }
    
    static func saveImageByNameAndLocation(image: UIImage, name: String, location: String){
        let fileUrl = createFileDirPath(pathLabel:  location).appendingPathComponent(name)
        if let _image = image.pngData(){
            try? _image.write(to: fileUrl)
        }
    }
    
    static func getDocumentImage(imagePath: String) -> UIImage?{
        var image: UIImage?
        do {
            image = UIImage(data: try Data(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imagePath)))
        } catch {
            print("Error loading OOTDStickerView image : \(error)")
        }
        return image
    }
}

