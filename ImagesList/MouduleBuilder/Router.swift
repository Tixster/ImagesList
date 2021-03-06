//
//  Router.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

protocol RouterLogic {
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderLogic { get set }
    func initMainController()
    func showDetail(imageItem: StoreImage)
}

final class Router: RouterLogic {
    
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderLogic
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderLogic) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initMainController() {
        let mainViewController = assemblyBuilder.createMainModule(router: self)
        navigationController.viewControllers = [mainViewController]
    }
    
    func showDetail(imageItem: StoreImage) {
        let detailViewController = assemblyBuilder.createDetailModule(router: self, imageItem: imageItem)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    
}
