//
//  EventDataManager.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation
import UIKit
import Alamofire

class EventDataManager: RequestHandler {}


extension EventDataManager: EventDataManagerProtocol {
    
    func fetchUsers(studentID: Int, completion: @escaping NetworkResultBlock<[Products]>) {
        
        let request = APIRequest(urlString: EventEndpoint.getProductsData.rawValue,
                                 method: .get,
                                 parameters: [:])
        APIService.performRequest(request, completion: baseResult(completion: completion))
    }
}


