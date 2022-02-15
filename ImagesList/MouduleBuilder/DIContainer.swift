//
//  DIContainer.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import Foundation

protocol DIContainerLogic {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component?
}

final class DIConteiner: DIContainerLogic {
    
    static let shared: DIConteiner = .init()
    
    private init() {}
    
    private var components: [String: Any] = .init()
    
    
    func register<Component>(type: Component.Type, component: Any) {
        self.components["\(type)"] = component
    }
    
    func resolve<Component>(type: Component.Type) -> Component? {
        return components["\(type)"] as? Component
    }
    
}
