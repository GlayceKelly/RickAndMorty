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
    func fetchMultipleEpisodies(pages: String?, completion: @escaping(AFResult<[Episodies]>) -> Void)
    func fetchSingleEpisodie(page: String?, completion: @escaping(AFResult<Episodies>) -> Void)
}

class EpisodiesService: EpisodiesServiceProtocol {
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    func fetchMultipleEpisodies(pages: String?, completion: @escaping (AFResult<[Episodies]>) -> Void) {
        
        guard let pages: String = pages else { return }
        var url: String = ""
        url = "\(basePath)episode/\(pages)"
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let responseData: Data = response.data else { return }
                    
                    let episodies: [Episodies] = try JSONDecoder().decode([Episodies].self, from: responseData)
                    completion(.success(episodies))
                    print("Response URL: \(url) \n \(data)")
                } catch {
                    print("Error EpisodiesService/fetchMultipleEpisodies: \(error.localizedDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSingleEpisodie(page: String?, completion: @escaping (AFResult<Episodies>) -> Void) {
        guard let page: String = page else { return }
        var url: String = ""
        url = "\(basePath)episode/\(page)"
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let responseData: Data = response.data else { return }
                    
                    let episodie: Episodies = try JSONDecoder().decode(Episodies.self, from: responseData)
                    completion(.success(episodie))
                    print("Response URL: \(url) \n \(data)")
                } catch {
                    print("Error EpisodiesService/fetchSingleEpisodie: \(error.localizedDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
