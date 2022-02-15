//
//  AppDelegate.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }
    
    private func setup() {
        let container = DIConteiner.shared
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        let networkDataFethcer = NetworkDataFetcher(networkService: NetworkService())
        container.register(type: AssemblyBuilderLogic.self, component: assemblyBuilder)
        container.register(type: RouterLogic.self, component: router)
        container.register(type: NetworkDataFetcherLogic.self, component: networkDataFethcer)
        router.initMainController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

