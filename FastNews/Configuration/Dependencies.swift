//
//  Dependencies.swift
//  FastNews
//
//  Created by Serhan Khan on 22/09/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import SwinjectAutoregistration
import Moya

class Dependencies {
    let container = Container()
    
    init() {
        self.configure()
    }
    
    func configure(){
        
    }
    
    func resolve<Service>()->Service {
        return resolve(Service.self)
    }
    
    func resolve<Service>(_ service:Service.Type) -> Service {
        return container.resolve(service)!
    }
    
    
}
