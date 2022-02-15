//
//  Networking.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import Foundation

protocol Networking {
    func requestImagesList(url: URL, completion: @escaping ((Result<[Image], Error>) -> Void))
}

final class NetworkService: Networking {
    
    func requestImagesList(url: URL, completion: @escaping ((Result<[Image], Error>) -> Void)) {
        DispatchQueue.global(qos: .userInteractive).async {
            let task = self.session.dataTask(with: url) { data, _, error in
                guard let imageData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                do {
                    let images = try JSONDecoder().decode([Image].self, from: imageData)
                    completion(.success(images))
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
}

private extension NetworkService {
    
    var session: URLSession {
        return URLSession.shared
    }
    
}
