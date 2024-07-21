//
//  EventDetailsViewProtocol.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

protocol EventDetailsViewProtocol: AnyObject {

    func showItems(items: [Products])
    func showError(error: String)
}
