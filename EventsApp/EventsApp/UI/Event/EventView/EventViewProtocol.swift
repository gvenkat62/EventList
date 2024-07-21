//
//  EventProtocal.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

protocol EventViewProtocol: AnyObject {

    func showItems(items: [Products])
    func showError(error: String)
}
