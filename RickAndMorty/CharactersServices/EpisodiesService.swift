//
//  EpisodiesService.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 26/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import Alamofire

protocol EpisodiesServiceProtocol: class {
    func fetchEpisodies(page: String?, completion: @escaping(AFResult<EpisodiesResult>) -> Void)
}

class EpisodiesService: EpisodiesServiceProtocol {
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    func fetchEpisodies(page: String?, completion: @escaping (AFResult<EpisodiesResult>) -> Void) {
        var url: String = ""
        
        if let page: String = page {
            url = "\(basePath)episode/?page=\(page)"
        } else {
            url = "\(basePath)episode/"
        }
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let responseData = response.data else { return }
                    
                    let episodies: EpisodiesResult = try JSONDecoder().decode(EpisodiesResult.self, from: responseData)
                    completion(.success(episodies))
                    print("Response URL: \(url) \n \(data)")
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
