//
//  RequestHandler.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation


typealias NetworkResult<T> = Result<T, ErrorResult>
typealias NetworkResultBlock<T> = ((NetworkResult<T>) -> Void)
typealias EmptyResultBlock = ((ErrorResult?) -> Void)

class RequestHandler {
    
    private let dispatchQueue = DispatchQueue(label: "com.tokenRepositoryQueue")
    private var refreshCompletions: [EmptyResultBlock] = []
    private var isInRefreshing = false

    func baseResult<T: JSONable>(completion: @escaping NetworkResultBlock<T>) ->
        ((APIRequest, Result<Data, ErrorResult>) -> Void) {
            return { (request, dataResult) in
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case .success(let data):
                        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                            completion(.failure(ErrorResult.parser(string: "Invalid JSON")))
                            return
                            
                        }
                        print("API");
                        print(request.urlString);
                        print("Parameters");
                        print(request.parameters);
                        print("Response");
                        print(jsonObject);
                        
                        guard let baseJson = jsonObject as? JSONDict,
                              let model = BaseResponse(json: baseJson) else {
                                  completion(.failure(ErrorResult.parser(string: "Can't parse JSON")))
                                  return
                              }
                        
                        
                        
                        
                        
                        guard let data = T(json: model.data) else {
                            completion(.failure(ErrorResult.parser(string: "Can't parse JSON")))
                            return
                        }

                        completion(.success(data))
                        

//                        guard let baseJson = jsonObject as? JSONDict,
//                              let model = Products(json: baseJson) else {
//                                  completion(.failure(ErrorResult.parser(string: "Can't parse JSON")))
//                                 return
//                              }
//                        
//                        completion(.success(model as! T))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
    }

}

/*
guard let baseJson = jsonObject as? JSONDict,
      let model = BaseResponse(json: baseJson) else {
          BugReporter.recordServerIssue(request: request, response: data)
          completion(.failure(ErrorResult.parser(string: "Can't parse JSON")))
          return
      }

guard model.isAuthenticated else {
    self.refreshToken { error in
        if let error = error {
            completion(.failure(error))
        } else {
            APIService.performRequest(request, completion: self.baseResult(completion: completion))
        }
            
    }
    BugReporter.recordServerIssue(request: request, response: data)
    return
}

guard model.status else {
    BugReporter.recordServerIssue(request: request, response: data)
    completion(.failure(ErrorResult.server(string: model.error ?? model.message ?? L10n.somethingWentWrong)))
    return
}

guard let data = T(json: model.data) else {
    BugReporter.recordServerIssue(request: request, response: data)
    completion(.failure(ErrorResult.parser(string: "Can't parse JSON")))
    return
}

completion(.success(data))
*/

