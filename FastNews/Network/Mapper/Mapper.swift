//
//  Mapper.swift
//  FastNews
//
//  Created by Serhan Khan on 04.07.22.
//

import Foundation
import RxSwift
import Moya
import Mapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.map(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.map(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If you want to throw an error on any failure, use `map()` instead.
    public func compactMap<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.compactMap(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Single<T?> {
        return flatMap { response -> Single<T?> in
            do {
                let object = try response.map(to: type, keyPath: keyPath)
                return Single.just(object)
            } catch {
                return Single.just(nil)
            }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]?> {
        return flatMap { response -> Single<[T]?> in
            do {
                let object = try response.map(to: type, keyPath: keyPath)
                return Single.just(object)
            } catch {
                return Single.just(nil)
            }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If the whole conversion fails, the nil is returned instead of error signal.
    /// Please see `map` and `compactMap` for other solutions to this problem.
    public func compactMapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]?> {
        return flatMap { response -> Single<[T]?> in
            do {
                let object = try response.compactMap(to: type, keyPath: keyPath)
                return Single.just(object)
            } catch {
                return Single.just(nil)
            }
        }
    }
}

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where Element == Response {
    
    /// Maps data received from the signal into an object which implement the Mappable protocol
    /// If the conversion fails, error event is sent.
    func map<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.map(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, the error event is sent.
    /// If you want to remove the object from an array on error, use `compactMap()` instead.
    func map<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.map(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If you want to throw an error on any failure, use `map()` instead.
    func compactMap<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.compactMap(to: type, keyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an object which implement the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    func mapOptional<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
            do {
                let object = try response.map(to: type, keyPath: keyPath)
                return Observable.just(object)
            } catch {
                return Observable.just(nil)
            }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    func mapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]?> {
        return flatMap { response -> Observable<[T]?> in
            do {
                let object = try response.map(to: type, keyPath: keyPath)
                return Observable.just(object)
            } catch {
                return Observable.just(nil)
            }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If the whole conversion fails, the nil is returned instead of error signal.
    /// Please see `map` and `compactMap` for other solutions to this problem.
    func compactMapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]?> {
        return flatMap { response -> Observable<[T]?> in
            do {
                let object = try response.compactMap(to: type, keyPath: keyPath)
                return Observable.just(object)
            } catch {
                return Observable.just(nil)
            }
        }
    }
}

public extension ObservableType where Element == Response {
    
    @available(*, unavailable, renamed: "map(to:keyPath:)")
    func mapObject<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<T> { fatalError() }
    
    @available(*, unavailable, renamed: "map(to:keyPath:)")
    func mapArray<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]> { fatalError() }
    
    @available(*, unavailable, renamed: "mapOptional(to:keyPath:)")
    func mapObjectOptional<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<T?> { fatalError() }
    
    @available(*, unavailable, renamed: "mapOptional(to:keyPath:)")
    func mapArrayOptional<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]?> { fatalError() }
}

public extension Response {
    
    func map<T: Mappable>(to type: T.Type) throws -> T {
        guard let jsonDictionary = try mapJSON() as? NSDictionary else {
            throw MoyaError.jsonMapping(self)
        }
        
        do {
            return try T(map: Mapper(JSON: jsonDictionary))
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func map<T: Mappable>(to type: T.Type, keyPath: String?) throws -> T {
        guard let keyPath = keyPath else { return try map(to: type) }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
              let objectDictionary = jsonDictionary.value(forKeyPath: keyPath) as? NSDictionary else {
            throw MoyaError.jsonMapping(self)
        }
        
        do {
            return try T(map: Mapper(JSON: objectDictionary))
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func map<T: Mappable>(to type: [T].Type) throws -> [T] {
        guard let jsonArray = try mapJSON() as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }
        
        do {
            return try jsonArray.map { try T(map: Mapper(JSON: $0)) }
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func compactMap<T: Mappable>(to type: [T].Type) throws -> [T] {
        guard let jsonArray = try mapJSON() as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return jsonArray.compactMap { try? T(map: Mapper(JSON: $0)) }
    }
    
    func map<T: Mappable>(to type: [T].Type, keyPath: String?) throws -> [T] {
        guard let keyPath = keyPath else { return try map(to: type) }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
              let objectArray = jsonDictionary.value(forKeyPath: keyPath) as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }
        
        do {
            return try objectArray.map { try T(map: Mapper(JSON: $0)) }
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func compactMap<T: Mappable>(to type: [T].Type, keyPath: String?) throws -> [T] {
        guard let keyPath = keyPath else { return try compactMap(to: type) }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
              let objectArray = jsonDictionary.value(forKeyPath: keyPath) as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return objectArray.compactMap { try? T(map: Mapper(JSON: $0)) }
    }
}
