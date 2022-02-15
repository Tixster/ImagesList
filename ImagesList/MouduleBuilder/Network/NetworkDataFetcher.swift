//
//  NetworkDataFetcher.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(String)
}

protocol NetworkDataFetcherLogic {
    func getImagesList(completion: @escaping (Result<[Image], Error>) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherLogic {
    
    var networkService: Networking
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    func getImagesList(completion: @escaping (Result<[Image], Error>) -> Void) {
        do {
            let url = try getURL(atPath: .photos)
            networkService.requestImagesList(url: url) { result in
                switch result {
                case .success(let images):
                    completion(.success(images))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    
}

private extension NetworkDataFetcher {
    
    enum PathUrlList: String {
        case photos = "/photos"
    }
    
    func getURL(atPath path: PathUrlList) throws -> URL {
        
        var compontents = URLComponents()
        compontents.scheme = "https"
        compontents.host = "jsonplaceholder.typicode.com"
        compontents.path = path.rawValue
        if let url = compontents.url {
            return url
        }
        throw NetworkError.invalidURL("Неправильная ссылка")
    }
    
}
