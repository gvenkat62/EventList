//
//  EventViewController.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

class EventViewController: UIViewController, EventViewProtocol, UISearchResultsUpdating {
    
    
    var presenter: EventPresenterProtocol!
    var items:[Products]! = []
    var searchItems:[Products]! = []
    
    
    var searchText = ""
    var isFiltered = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventTableViewCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 130
        
        
        
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.searchBar.tintColor = UIColor.white
        //searchController.searchBar.backgroundColor = UIColor.white
        searchController.searchBar.searchTextField.textColor = UIColor.white
        searchController.searchBar.setupSearchBar()

        searchController.searchBar.barTintColor = UIColor(red: 56/255, green: 67/255, blue: 78/255, alpha: 1.0)

        searchController.automaticallyShowsCancelButton = true
        return searchController
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkAndUpdateFavouriteIcon()
    }
    
    func setupLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    func checkAndUpdateFavouriteIcon(){
        let visibleIndexPaths = tableView.indexPathsForVisibleRows!
        
        _ = visibleIndexPaths.filter { indexPath in
            // Filter out all the partially visible cells
            if let cell = tableView.cellForRow(at: indexPath) as? EventTableViewCell
            {
                let item = searchController.isActive ? self.searchItems[indexPath.row] : self.items[indexPath.row]
                let isFavourite =  UserDefaults.standard.bool(forKey: "\(String(describing: item.id))")
                cell.updateFavouriteIcon(isFav: isFavourite)
            }
            
            let cellFrame = tableView.rectForRow(at: indexPath)
            let isCellFullyVisible = tableView.bounds.contains(cellFrame)
            return isCellFullyVisible
        }
    }
}

//MARK: - UITableViewDelegate && UITableViewDataSource

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchItems.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cellForRowAt(for: indexPath)
    }
    
    
    func cellForRowAt(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let item = searchController.isActive ? self.searchItems[indexPath.row] : self.items[indexPath.row]
        cell.item = item
        cell.bindData()
        cell.canFavouriteIconObservable.observe(on: self) { isFavourite in
            cell.updateFavouriteIcon(isFav: isFavourite)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = EventDetailsViewController()
        let presenter = EventDetailsPresenter(view: viewController, items: [searchController.isActive ? self.searchItems[indexPath.row] : self.items[indexPath.row]])
        viewController.presenter = presenter
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension EventViewController: UISearchBarDelegate {
    
    func filterContentForSearchText(_ searchText: String) {
        searchItems = items.filter({ (product:Products) -> Bool in
            let titleMatch = product.title!.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let descrptionMatch = product.description!.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil || descrptionMatch != nil}
        )
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
}


extension UITableView {
    
    func isCellAtIndexPathFullyVisible(_ indexPath: IndexPath) -> Bool {
        let cellFrame = rectForRow(at: indexPath)
        return bounds.contains(cellFrame)
    }
    
    func indexPathsForFullyVisibleRows() -> [IndexPath] {
        let visibleIndexPaths = indexPathsForVisibleRows ?? []
        return visibleIndexPaths.filter { indexPath in
            return isCellAtIndexPathFullyVisible(indexPath)
        }
    }
}
