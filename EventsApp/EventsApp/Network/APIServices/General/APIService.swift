//
//  APIService.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Alamofire
import Foundation

class APIService {
    
    static var apiUrl: String? = nil
    static var multiPartData: Dictionary<String, Any> = [:]
    
    static func performRequest(_ request: APIRequest,
                               completion: @escaping (APIRequest, NetworkResult<Data>) -> Void) {
        let headers = createHeaders(request.additionalHeaders)
        var urlString = request.urlString
        if request.method == .get {
            urlString = urlString.URLStringAppending(request.parameters)
        }
        print("API");
        print(request.urlString);
        print("Parameters");
        print(request.parameters);
        print("headers");
        print(headers);
        AF.request(urlString,
                   method: request.method,
                   parameters: request.method == .get || request.parameters.isEmpty ? nil : request.parameters,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   requestModifier: { $0.timeoutInterval = request.timeout })
        .responseData { response in
            switch response.result {
            case .success(let data):
                completion(request, .success(data))
            case .failure(let error):
                completion(request, .failure(.network(string: error.localizedDescription, code: error.responseCode ?? -1)))
            }
        }
    }
    
}

// MARK: - Private
private extension APIService {
    
    static var defaultHeaders: HTTPHeaders {
        return HTTPHeaders()
    }
    
    static func createHeaders(_ additionalHeaders: HTTPHeaders? = nil) -> HTTPHeaders {
        return defaultHeaders
    }
    
}
