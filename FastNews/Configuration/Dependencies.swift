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
    
    func configure() {
        
    }
    
    func resolve<Service>() -> Service {
        return resolve(Service.self)
    }
    
    func resolve<Service>(_ service: Service.Type) -> Service {
        return container.resolve(service)!
    }
    
    public func resolve<Service, Arg1>(_ service: Service.Type, argument: Arg1) -> Service {
        return container.resolve(Service.self, argument: argument)!
    }
    
    public func resolve<Service, Arg1, Arg2>(_ service: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        return container.resolve(Service.self, arguments: arg1, arg2)!
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3>(_ service: Service.Type,
                                                   arguments arg1: Arg1,
                                                   _ arg2: Arg2,
                                                   _ arg3: Arg3) -> Service {
        return container.resolve(Service.self, arguments: arg1, arg2, arg3)!
    }
    
}
