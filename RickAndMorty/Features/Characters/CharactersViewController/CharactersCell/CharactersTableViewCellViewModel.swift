//
//  CharactersTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 26/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation

class CharactersTableViewCellViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewControllerTitle: String {
        return "Detail"
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
    
    init(generalService: GeneralServiceProtocol, characterService: CharacterServiceProtocol) {
        self.generalService = generalService
        self.characterService = characterService
    }
}
