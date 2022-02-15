//
//  FileManager.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

extension FileManager {
    
    func getFolerURL(atName name: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(name)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

