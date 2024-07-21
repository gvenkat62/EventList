//
//  JSONDict.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

typealias JSONDict = [String: Any]

extension JSONDict {
    func string(key: String) -> String? {
        let str = self[key] as? String
		if str == nil {
			// print("String for key: <\(key)> is not found")
		}
        return str
    }
    
    func stringValue(key: String, defaultValue value: String = "") -> String {
        return string(key: key) ?? value
    }
   
    func decimal(key: String) -> Decimal? {
        guard let decimalString = string(key: key) else {
			// print("Decimal for key: <\(key)> is not found")
			return nil
		}
        return Decimal(string: decimalString)
    }
    
    func int(key: String) -> Int? {
		let integer = self[key] as? Int
		if integer == nil {
			// print("Int for key: <\(key)> is not found")
		}
        return integer
    }
    
    func intValue(key: String, defaultValue value: Int = 0) -> Int {
        return int(key: key) ?? value
    }
	
	func double(key: String) -> Double? {
		let double = self[key] as? Double
		if double == nil {
			// print("Int for key: <\(key)> is not found")
		}
		return double
	}
	
	func doubleValue(key: String, defaultValue value: Double = 0.0) -> Double {
		return double(key: key) ?? value
	}
    
    func bool(key: String) -> Bool? {
		let boolean = self[key] as? Bool
		if boolean == nil {
			// print("Bool for key: <\(key)> is not found")
		}
        return boolean
    }
    
    func boolValue(key: String, defaultValue value: Bool = false) -> Bool {
        return bool(key: key) ?? value
    }

    func decimalValue(key: String, defaultValue value: Decimal = Decimal.zero) -> Decimal {
        return decimal(key: key) ?? value
    }

    func dictionary(key: String) -> JSONDict? {
		let dict = self[key] as? JSONDict
		if dict == nil {
			// print("Dictionary for key: <\(key)> is not found")
		}
        return dict
    }
    
    func dictionaryValue(key: String, defaultValue value: JSONDict = [:]) -> JSONDict {
        return dictionary(key: key) ?? value
    }

    func array<T>(key: String) -> [T]? {
		let array = (self[key] as? [Any])?.compactMap { $0 as? T }
		if array == nil {
			// print("Array for key: <\(key)> is not found")
		}
        return array
    }

    func arrayValue<T>(key: String) -> [T] {
        return self[key] as? [T] ?? []
    }
    
    func array<T: JSONable>(key: String) -> [T]? {
		let array = (self[key] as? [JSONDict])?.compactMap { T(json: $0) }
		if array == nil {
			// print("Array for key: <\(key)> is not found")
		}
        return array
    }

    func arrayValue<T: JSONable>(key: String) -> [T] {
        return array(key: key) ?? []
    }

    var description: String {
        reduce("") { (result: String, keyValue: (String, Any)) -> String in
            return result + keyValue.0 + ": \(keyValue.1),"
        }
    }
    
}
