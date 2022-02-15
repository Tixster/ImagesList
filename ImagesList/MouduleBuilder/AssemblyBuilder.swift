//
//  AssemblyBuilder.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

protocol AssemblyBuilderLogic {
    func createMainModule(router: RouterLogic) -> UIViewController
    func createDetailModule(router: RouterLogic, imageItem: StoreImage) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderLogic {
    
    func createMainModule(router: RouterLogic) -> UIViewController {
        let mainViewController = MainViewController()
        let presenter = MainPresenter(view: mainViewController)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
    func createDetailModule(router: RouterLogic, imageItem: StoreImage) -> UIViewController {
        let detailViewController = DetailViewController()
        let presenter = DetailPresenter(view: detailViewController, imageItem: imageItem)
        detailViewController.presenter = presenter
        return detailViewController
    }
    

}
