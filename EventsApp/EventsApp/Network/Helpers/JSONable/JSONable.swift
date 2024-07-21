//
//  JSONable.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

protocol JSONable {
    init?(json: JSONDict)
}

extension Array: JSONable where Element: JSONable {
    init?(json: JSONDict) {
        guard let data = json["items"] as? [JSONDict] else { return nil }
        self = data.compactMap { Element(json: $0) }
    }
}
