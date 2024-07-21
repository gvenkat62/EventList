//
//  ViewController.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = EventViewController()
        let dataManager = EventDataManager()
        
        let presenter = EventPresenter(view: viewController, dataManager: dataManager)
        viewController.presenter = presenter
        guard let window = self.window else{return}
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setupNavigationController()
        window.rootViewController = navigationController
        
        // Do any additional setup after loading the view.
    }
    
}

