//
//  CharactersDetailViewModel.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 30/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewControllerTitle: String {
        return "Detail"
    }
    
    var characterName: String {
        guard let name: String = results?.name else { return "" }
        return name
    }
    
    var characterSpecies: String {
        guard let species: String = results?.species else { return "" }
        return species
    }
    
    var characterOriginName: String {
        guard let origin: String = results?.origin.name else { return "" }
        return origin
    }
    
    var characterImage: String {
        guard let image: String = results?.image else { return "" }
        return image
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var results: Results?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(results: Results) {
        self.results = results
    }
}

//*************************************************
// MARK: - Public methods
//*************************************************

extension CharacterDetailViewModel {
    func navigateToEpisodiesScreen(viewController: UIViewController) {
        let episodiesService: EpisodiesService = EpisodiesService()
        let viewModel: EpisodiesCharacterViewModel = EpisodiesCharacterViewModel(episodiesService: episodiesService, results: results)
        let episodiesViewController: UIViewController = EpisodiesCharacterViewController(episodiesURLs: results?.episode, episodiesViewModel: viewModel)
        
        viewController.present(episodiesViewController, animated: true, completion: nil)
    }
}
