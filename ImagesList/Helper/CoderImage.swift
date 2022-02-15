//
//  CoderImage.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

protocol CoderImageLogic {
    func encodeToJSON(_ item: StoreImage)
    func encodeImageList() -> [StoreImage]
}

class CoderImage: CoderImageLogic {
    
    private let folderName = "jsonImage"
    private let fileName = "stored_images"
    private var storeImageList: [StoreImage] = .init()
    private(set) var decodedImageList: [StoreImage] = .init()
    
    init() {
        createFolderIfNeeded()
    }

    func encodeToJSON(_ item: StoreImage) {
        self.storeImageList.append(item)
        do {
            let jsonData = try JSONEncoder().encode(storeImageList)
            let url = FileManager.default.getFolerURL(atName: folderName)
            let fileURL = url.appendingPathComponent(fileName).appendingPathExtension("json")
            try jsonData.write(to: fileURL)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func encodeImageList() -> [StoreImage] {
        decodeFromJSON()
        decodedImageList.sort { $0.index < $1.index }
        return decodedImageList
    }
    
}

private extension CoderImage {
    
    func createFolderIfNeeded() {
        let url = FileManager.default.getFolerURL(atName: folderName)
        guard !FileManager.default.fileExists(atPath: url.path) else { return }
        do {
            try FileManager.default.createDirectory(at: url,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
            print("Папка создана!")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func decodeFromJSON() {
        do {
            let url = FileManager.default.getFolerURL(atName: folderName)
            let fileURL = url.appendingPathComponent(fileName).appendingPathExtension("json")
            let jsonData = try Data(contentsOf: fileURL)
            let decodedImages = try JSONDecoder().decode([StoreImage].self, from: jsonData)
            self.decodedImageList = decodedImages
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
