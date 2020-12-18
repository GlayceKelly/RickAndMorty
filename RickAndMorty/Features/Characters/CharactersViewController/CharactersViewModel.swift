//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 29/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewControllerTitle: String {
        return "Characters"
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************

    private var generalService: GeneralServiceProtocol
    private var characterService: CharacterServiceProtocol
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var characterURL: String = ""
    var results: [Results] = []
    var character: Character?
    var loadingCharacters = false
    var currentPage: Int = 1
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(generalService: GeneralServiceProtocol = GeneralService(), characterService: CharacterServiceProtocol = CharacterService()) {
        self.generalService = generalService
        self.characterService = characterService
    }
    
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension CharactersViewModel {
    func loadURLs() {
        self.generalService.fetchURLs(page: nil) { (result) in
            switch result {
            case .success(let rickAndMortyURLs):
                self.characterURL = rickAndMortyURLs.characters
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func loadCharacters(tableView: UITableView) {
        self.characterService.fetchCharacters(page: String(currentPage)) { (result) in
            switch result  {
            case .success(let character):
                self.character = character
                self.results += character.results
                self.loadingCharacters = false
                
                tableView.reloadData()
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func fetchNextPage(tableView: UITableView) {
        currentPage += 1
        loadCharacters(tableView: tableView)
    }
}
