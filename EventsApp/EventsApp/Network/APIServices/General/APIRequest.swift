//
//  APIRequest.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Alamofire
import Foundation

class APIRequest {
    let urlString: String
    let method: HTTPMethod
    let parameters: JSONDict
    let additionalHeaders: HTTPHeaders
    let timeout: TimeInterval
    
    init(urlString: String,
         method: HTTPMethod = .get,
         parameters: JSONDict = [:],
         additionalHeaders: HTTPHeaders = [],
         timeout: TimeInterval = 60) {
        self.urlString = APIConstants.API_URL+urlString
        self.method = method
        self.parameters = parameters
        self.additionalHeaders = additionalHeaders
        self.timeout = timeout
    }
    
}


