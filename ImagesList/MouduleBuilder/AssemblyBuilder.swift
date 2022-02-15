//
//  AssemblyBuilder.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

protocol AssemblyBuilderLogic {
    func createMainModule(router: RouterLogic) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderLogic {
    
    func createMainModule(router: RouterLogic) -> UIViewController {
        let mainViewController = MainViewController()
        let presenter = MainPresenter(view: mainViewController)
        mainViewController.presenter = presenter
        return mainViewController
    }
    

}
