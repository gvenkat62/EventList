//
//  ViewExtension.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation
import UIKit


extension String {
    func URLStringAppending(_ queryParams: JSONDict) -> String {
        guard let url = URL(string: self),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return self }
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)") }
        return urlComponents.url?.absoluteString ?? self
    }
}
