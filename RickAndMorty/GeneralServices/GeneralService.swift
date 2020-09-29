//
//  GeneralService.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 29/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import Alamofire

protocol GeneralServiceProtocol: class {
    func fetchURLs(page: String?, completion: @escaping(AFResult<RickAndMortyURLs>) -> Void)
}

class GeneralService: GeneralServiceProtocol {
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    func fetchURLs(page: String?, completion: @escaping (AFResult<RickAndMortyURLs>) -> Void) {
        let url: String = basePath
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let urls: RickAndMortyURLs = try JSONDecoder().decode(RickAndMortyURLs.self, from: response.data!)
                    completion(.success(urls))
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
