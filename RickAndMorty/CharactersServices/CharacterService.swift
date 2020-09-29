//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 29/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import Alamofire

protocol CharacterServiceProtocol: class {
    func fetchCharacters(page: String?, completion: @escaping(AFResult<Character>) -> Void)
}

class CharacterService: CharacterServiceProtocol {
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    func fetchCharacters(page: String?, completion: @escaping (AFResult<Character>) -> Void) {
        var url: String = ""
        
        if let page: String = page {
            url = "\(basePath)character/?page=\(page)"
        } else {
            url = "\(basePath)character/"
        }
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let characters: Character = try JSONDecoder().decode(Character.self, from: response.data!)
                    completion(.success(characters))
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
