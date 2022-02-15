//
//  ImageModelFileManager.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

protocol ImageModelFileManagerLogic {
    func add(key: Int, value: UIImage)
    var encodeImageItems: [StoreImage] { get }
}

final class ImageModelFileManager: ImageModelFileManagerLogic {
    
    private let folderName = "Images"
    private let coder: CoderImageLogic = CoderImage()
    var encodeImageItems: [StoreImage] {
        return coder.encodeImageList()
    }
    
    init() {
        createFolderIfNeeded()
    }
    
    func add(key: Int, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImageURL(forKey: "\(key)")
        else { return }
        do {
            try data.write(to: url)
            let item = StoreImage(index: key, path: url,
                                  date: Date())
            coder.encodeToJSON(item)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

private extension ImageModelFileManager {
    
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
    
    func getImageURL(forKey key: String) -> URL? {
        let folderURL = FileManager.default.getFolerURL(atName: folderName)
        return folderURL.appendingPathComponent(key + ".png")
    }
    
}
