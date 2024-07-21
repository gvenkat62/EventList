//
//  BaseResponse.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

struct BaseResponse: JSONable {
	let status: Bool
	let data: JSONDict
	let message: String?
	let error: String?
	let isAuthenticated: Bool

	init?(json: JSONDict) {
        
        self.status = true
        self.message = "Data"
        self.error = "No error"
        self.isAuthenticated = true
        
		if let arrayData = json["products"] as? Array<Any> {
			self.data = ["items": arrayData]
		} else {
			self.data = json.dictionaryValue(key: "products")
		}
       
	}
}
