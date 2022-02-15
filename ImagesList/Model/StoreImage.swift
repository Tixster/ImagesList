//
//  StoreImage.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import Foundation

struct StoreImage: Codable {
    let index: Int
    let path: URL
    let date: Date
}
