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

extension UISearchBar{
    
        // Appearance proxies are applied when a view is added to a view hierarchy, so apply your tweaks after that:
         func setupSearchBar() {

            let placeholderColor = UIColor.white.withAlphaComponent(0.75)
            let placeholderAttributes = [NSAttributedString.Key.foregroundColor : placeholderColor]
            let attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)
            self.searchTextField.attributedPlaceholder = attributedPlaceholder
            // Make the magnifying glass the same color
             self.setImage(UIImage(systemName: "xmark.circle")?.withTintColor(placeholderColor), for: .clear, state: .normal)
             
            (self.searchTextField.leftView as? UIImageView)?.tintColor = placeholderColor
        }
    
}
