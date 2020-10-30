//
//  EpisodiesCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 28/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import UIKit

class EpisodiesCharacterViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewControllerTitle: String {
        return "Episodies"
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************

    private var episodiesService: EpisodiesService
    private var results: Results?
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var multipleEpisodies: [Episodies]?
    var singleEpisodie: Episodies?
    
    var loadingCharacters = false
    var currentPage: Int = 1
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(episodiesService: EpisodiesService, results: Results?) {
        self.episodiesService = episodiesService
        self.results = results
    }
    
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension EpisodiesCharacterViewModel {
    func loadMultipleEpisodies(tableView: UITableView?) {
        guard let episodies: [String] = results?.episode else { return }
        var pages: String = ""
        for (index, episodie) in episodies.enumerated() {
            let arrayURL = episodie.components(separatedBy: "/")
            if index < episodie.count - 1 {
                pages += ("\(arrayURL.last!),")
            } else {
                pages += (arrayURL.last!)
            }
        }
        
        let service: EpisodiesServiceProtocol = EpisodiesService()
        service.fetchMultipleEpisodies(pages: pages) { (result) in
            switch result {
            case .success(let episodies):
                self.multipleEpisodies = episodies
                tableView?.reloadData()
            case .failure(let error):
                print("Error EpisodiesCharacterViewModel/loadMultipleEpisodies: \(error.localizedDescription)")
            }
        }
    }
    
    func loadSingleEpisodie(tableView: UITableView?) {
        guard let episodies: String = results?.episode?.first else { return }
        let page: String = episodies.components(separatedBy: "/").last ?? ""
        
        let service: EpisodiesServiceProtocol = EpisodiesService()
        service.fetchSingleEpisodie(page: page) { (result) in
            switch result {
            case .success(let episodie):
                self.singleEpisodie = episodie
                tableView?.reloadData()
            case .failure(let error):
                print("Error EpisodiesCharacterViewModel/loadSingleEpisodie: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNextPage(tableView: UITableView) {
        currentPage += 1
        loadMultipleEpisodies(tableView: tableView)
    }
}
