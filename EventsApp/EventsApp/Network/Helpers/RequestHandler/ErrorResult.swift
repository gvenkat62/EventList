//
//  ErrorResult.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

enum ErrorCodes: Int {
    case custom
    case parser
    case unknown
    case wrongUrl
    case sessionExpired
}

enum ErrorResult: Error {
    case network(string: String, code: Int)
    case parser(string: String)
    case server(string: String)
    case custom(string: String, code: Int)
    case tokenRelated(message: String, isAuthenticated: Bool)
}

class AppError: NSError {
    static func create(_ error: ErrorResult) -> AppError {
        switch error {
        case .custom(let string, let code):
            return AppError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: string])
        case .network(let string, let code):
            return AppError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: string])
        case .parser(let string), .server(let string):
            return AppError(domain: "", code: ErrorCodes.parser.rawValue, userInfo: [NSLocalizedDescriptionKey: string])
        case .tokenRelated(message: let message, isAuthenticated: _):
            return AppError(domain: "", code: ErrorCodes.parser.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
        }
    }
}

