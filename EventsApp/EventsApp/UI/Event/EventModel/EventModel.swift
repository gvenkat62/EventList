//
//  EventModel.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

struct Products : JSONable {
    public var id : Int?
    public var title : String?
    public var description : String?
    public var category : String?
    public var price : Double?
    public var discountPercentage : Double?
    public var rating : Double?
    public var stock : Int?
    public var tags : [String]?
    public var brand : String?
    public var sku : String?
    public var weight : Int?
    public var warrantyInformation : String?
    public var shippingInformation : String?
    public var availabilityStatus : String?
    public var reviews : [Reviews]
    public var returnPolicy : String?
    public var minimumOrderQuantity : Int?
    public var images : [String]?
    public var thumbnail : String?
    
    init?(json: JSONDict) {
        id = json["id"] as? Int
        title = json["title"] as? String
        description = json["description"] as? String
        category = json["category"] as? String
        price = json["price"] as? Double
        discountPercentage = json["discountPercentage"] as? Double
        rating = json["rating"] as? Double
        stock = json["stock"] as? Int
        tags =  json.array(key:"tags")
        brand = json["brand"] as? String
        sku = json["sku"] as? String
        weight = json["weight"] as? Int
        warrantyInformation = json["warrantyInformation"] as? String
        shippingInformation = json["shippingInformation"] as? String
        availabilityStatus = json["availabilityStatus"] as? String
        reviews = json.array(key:"reviews") ?? []
        returnPolicy = json["returnPolicy"] as? String
        minimumOrderQuantity = json["minimumOrderQuantity"] as? Int
        images = json.array(key:"images")
        thumbnail = json["thumbnail"] as? String
    }
    
}

public struct Reviews :JSONable {
    public var rating : Int?
    public var comment : String?
    public var date : String?
    public var reviewerName : String?
    public var reviewerEmail : String?
    
    init?(json: JSONDict) {
        rating = json["rating"] as? Int
        comment = json["comment"] as? String
        date = json["date"] as? String
        reviewerName = json["reviewerName"] as? String
        reviewerEmail = json["reviewerEmail"] as? String
    }
}

