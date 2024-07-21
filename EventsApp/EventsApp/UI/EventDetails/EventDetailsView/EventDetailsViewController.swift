//
//  EventDetailsViewController.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

class EventDetailsViewController: UIViewController, EventDetailsViewProtocol {
   
    
    var presenter: EventDetailsPresenterProtocol!
    var items:[Products]! = []
    var onCompletion: ((Bool) -> Void)?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EventDetailsCell.self, forCellReuseIdentifier: "EventDetailsCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.rowHeight = 130
       
        
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .blue
        self.setupLayout()
        presenter.viewLoaded()
    }

    func showItems(items: [Products]) {
        self.items = items
        self.tableView.reloadData()
        // Code to update UI with the list of users goes here
    }

    func showError(error: String) {
        // Code to show an error message to the user goes here
    }
    
    func setupLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.navigationController?.navigationBar.tintColor = .lightGray
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.title = "Details"
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate && UITableViewDataSource

extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
                    return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cellForRowAt(for: indexPath)
    }
    
    
    func cellForRowAt(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailsCell", for: indexPath) as! EventDetailsCell
        
        let item =  self.items[indexPath.row]
        
        cell.item = item
        cell.bindData()

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

