//
//  WebImageView.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?, index: Int) {
        
        currentUrlString = imageURL
        
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return  }
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
        } else {
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let response = response {
                        self?.handleLoadedImage(data: data, response: response, index: index)
                    }
                }
            }
            dataTask.resume()
        }
        
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse, index: Int) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentUrlString {
            let image = UIImage(data: data)
            self.image = image
            let imageFileManager = DIConteiner.shared.resolve(type: ImageModelFileManagerLogic.self)!
            imageFileManager.add(key: index, value: image ?? UIImage())
        }
    }
}
