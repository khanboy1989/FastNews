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
    
    func configure() {
        configureClients()
        configureServices()
        configureSteppers()
        configureViewModels()
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
    
    private func configureClients() {
        // Api configs
        container.register(CategoryApiConfiguration.self) { _ in
            return Environment.current.categoryApiConfiguration
        }
        
        container.register(SourceApiConfiguration.self) { _ in
            return Environment.current.sourceApiConfiguration
        }
        
        // Api providers
        container.register(MoyaProvider<CategoryApi>.self) { _ in
            return Environment.current.categoryApiProvider
        }
        
        container.register(MoyaProvider<SourceApi>.self) { _ in
            return Environment.current.sourceApiProvider
        }
        
        // Clients
        container.autoregister(CategoryClient.self, initializer: CategoryClient.init)
        
        container.autoregister(SourceClient.self,
            initializer: SourceClient.init)
        
    }
    
    private func configureServices() {
        container.autoregister(ReachabilityServiceType.self, initializer: ReachabilityService.init)
        container.autoregister(CategoryServiceType.self, initializer: CategoryService.init)
        container.autoregister(SourceServiceType.self, initializer: SourceService.init)
    }
    
    private func configureViewModels() {
        container.autoregister(ViewModel.self, initializer: ViewModel.init)
        container.autoregister(TabBarViewModel.self, initializer: TabBarViewModel.init)
        container.autoregister(CategoriesViewModel.self, initializer: CategoriesViewModel.init)
        container.autoregister(SourcesViewModel.self, initializer: SourcesViewModel.init)
        container.autoregister(ArticleDetailViewModel.self, argument: Article.self, initializer: ArticleDetailViewModel.init)
        container.autoregister(SourceMainViewModel.self, argument: Source.self, initializer: SourceMainViewModel.init)
    }
    
    private func configureSteppers() {
        
    }
    
}
