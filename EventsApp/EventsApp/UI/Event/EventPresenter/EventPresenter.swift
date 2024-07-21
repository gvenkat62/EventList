//
//  EventPresenter.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation



class EventPresenter: EventPresenterProtocol {
    weak var view: EventViewProtocol?
    var dataManager: EventDataManagerProtocol
    
    
    init(view: EventViewProtocol, dataManager: EventDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func viewLoaded() {
        dataManager.fetchUsers(studentID:0) { [weak self] result in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.view?.showItems(items:response)
                    
                case .failure(let error):
                    self.view?.showError(error: error.localizedDescription)
                }
            }
            
        }
    }
}
