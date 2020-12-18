//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 30/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //*************************************************
    // MARK: - Constant
    //*************************************************
    
    static let shared: TabBarController = TabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
    }
    
    //*************************************************
    // MARK: - Methods
    //*************************************************
    
    func loadViewControllers() {
        var arrayViews: [UIViewController] = [UIViewController]()
        
        let characterViewModel: CharactersViewModel = CharactersViewModel()
        let charactersViewController: CharactersViewController = CharactersViewController(charactersViewModel: characterViewModel)
        charactersViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 1)
        arrayViews.append(charactersViewController)
        
        let episodiesService: EpisodiesService = EpisodiesService()
        let viewModel: EpisodiesCharacterViewModel = EpisodiesCharacterViewModel(episodiesService: episodiesService, results: nil)
        let episodiesViewController: UIViewController = EpisodiesCharacterViewController(episodiesURLs: nil, episodiesViewModel: viewModel)
        episodiesViewController.tabBarItem = UITabBarItem(title: "Episodies", image: nil, tag: 1)
        arrayViews.append(episodiesViewController)
        
        viewControllers = arrayViews
    }
}

extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!
        
        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}
