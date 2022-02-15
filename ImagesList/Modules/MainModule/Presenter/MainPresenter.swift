//
//  MainPresenter.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    func imagesDidFetch()
    func imagesDidFetchError(error: Error)
}

protocol MainPresenterLogic: AnyObject {
    init(view: MainPresenterDelegate, router: RouterLogic, networkDataFetcher: NetworkDataFetcherLogic)
    var imagesList: [Image] { get set }
    var encodeStoredImages: [StoreImage] { get }
    func getImagesList()
    func showDetail(imageItem: StoreImage)
}

final class MainPresenter: MainPresenterLogic {
    
    weak var view: MainPresenterDelegate?
    var router: RouterLogic
    var imagesList: [Image] = .init()
    var networkDataFetcher: NetworkDataFetcherLogic
    var encodeStoredImages: [StoreImage] {
        let imageFileManager = DIConteiner.shared.resolve(type: ImageModelFileManagerLogic.self)!
        return imageFileManager.encodeImageItems
    }
    
    init(view: MainPresenterDelegate,
         router: RouterLogic = DIConteiner.shared.resolve(type: RouterLogic.self)!,
         networkDataFetcher: NetworkDataFetcherLogic = DIConteiner.shared.resolve(type: NetworkDataFetcherLogic.self)!) {
        self.view = view
        self.router = router
        self.networkDataFetcher = networkDataFetcher
    }
    
    func getImagesList() {
        networkDataFetcher.getImagesList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let images):
                print(images)
                self.imagesList = images
                DispatchQueue.main.async {
                    self.view?.imagesDidFetch()                    
                }
            case .failure(let error):
                self.view?.imagesDidFetchError(error: error)
            }
        }
    }
    
    func showDetail(imageItem: StoreImage) {
        router.showDetail(imageItem: imageItem)
    }
    
}
