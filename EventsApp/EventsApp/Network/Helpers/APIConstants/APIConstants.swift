//
//  APIConstants.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

class APIConstants {


	//MARK: - General URLs
	// Server url
	static var API_URL: String {
			return "https://dummyjson.com/"
	}
}

enum EventEndpoint: String {
	case getProductsData = "products"
}

