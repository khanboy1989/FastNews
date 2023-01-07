//
//  ClientError.swift
//  FastNews
//
//  Created by Serhan Khan on 10/10/2021.
//

import Foundation
import Mapper
import Moya
import Alamofire

enum ClientError: Error {
    
    // generic errors
case invalidRequestData
case invalidResponseData(response: Response?)
case invalidResponseParsing(underlyingError: Error)
case invalidStatusCode(statusCode: Int, response: Response?)
case unknown(underlyingError: Error, response: Response?)
    
    init(fromError error: Error) {
        let clientError: ClientError
        if let error = error as? ClientError {
            clientError = error
        } else {
            clientError = ClientError.parseError(error, response: nil)
        }
        self = clientError
    }
}
extension ClientError {
    static func parseError(_ error: Error, response: Response?) -> ClientError {
        switch error {
        case let MoyaError.imageMapping(response),
             let MoyaError.jsonMapping(response),
             let MoyaError.stringMapping(response),
             let MoyaError.objectMapping(_, response):
            return ClientError.invalidResponseData(response: response)
        case is MapperError:
            return ClientError.invalidResponseParsing(underlyingError: error)
        case MoyaError.encodableMapping,
             MoyaError.requestMapping,
             MoyaError.parameterEncoding:
            return ClientError.invalidRequestData
        case let MoyaError.statusCode(response):
            return ClientError.invalidStatusCode(statusCode: response.statusCode, response: response)
        case let error as AFError:
            return parseAFError(error, response: response)
        case let MoyaError.underlying(error, response):
            // call recursively
            return parseError(error, response: response)
        default:
            return ClientError.unknown(underlyingError: error, response: nil)
        }
    }
    
    private static func parseAFError(_ error: AFError, response: Response?) -> ClientError {
        switch error {
        case let .responseValidationFailed(reason):
            switch reason {
            case let .unacceptableStatusCode(code):
                return ClientError.invalidStatusCode(statusCode: code, response: response)
            default:
                return ClientError.unknown(underlyingError: error, response: response)
            }
        default:
            return ClientError.unknown(underlyingError: error, response: response)
        }
    }
}
