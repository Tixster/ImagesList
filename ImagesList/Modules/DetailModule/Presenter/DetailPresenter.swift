//
//  DetailPresenter.swift
//  ImagesList
//
//  Created by Кирилл Тила on 16.02.2022.
//

import UIKit

protocol DetailPresenterDelegate: AnyObject {
    func setImageContent(imageItem: StoreImage)
}

protocol DetailPresenterLogic: AnyObject {
    init(view: DetailPresenterDelegate, router: RouterLogic, imageItem: StoreImage)
    func setImageItem()
}

final class DetailPresenter: DetailPresenterLogic {
    
    weak var delegate: DetailPresenterDelegate?
    var router: RouterLogic
    let imageItem: StoreImage
    
    init(view: DetailPresenterDelegate,
         router: RouterLogic = DIConteiner.shared.resolve(type: RouterLogic.self)!,
         imageItem: StoreImage) {
        self.delegate = view
        self.router = router
        self.imageItem = imageItem
    }
    
    func setImageItem() {
        delegate?.setImageContent(imageItem: imageItem)
    }
    
}
