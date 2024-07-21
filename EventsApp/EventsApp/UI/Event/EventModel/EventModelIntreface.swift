//
//  EventModelIntreface.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

protocol EventDataManagerProtocol {
    func fetchUsers(studentID: Int, completion: @escaping NetworkResultBlock<[Products]>)
}
