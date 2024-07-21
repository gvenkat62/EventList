//
//  EventDetailsPresenter.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

class EventDetailsPresenter: EventDetailsPresenterProtocol {
    weak var view: EventDetailsViewProtocol?
    var items:[Products]! = []


    init(view: EventDetailsViewProtocol, items: [Products]) {
        self.view = view
        self.items = items
    }

    func viewLoaded() {
        self.view?.showItems(items:self.items)

    }
}
