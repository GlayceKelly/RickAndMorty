//
//  CharacterAPI.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 26/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation
import Alamofire

class GeneralAPI {
    static var shared = GeneralAPI()
    
    static private let basePath = "https://rickandmortyapi.com/api/"
    
    class func loadURLs(onComplete: @escaping (RickAndMortyURLs?) -> Void) {
        let url: String = basePath
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            
            do {
                let urls = try JSONDecoder().decode(RickAndMortyURLs?.self, from: data)
                onComplete(urls)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    class func loadCharacters(page: String?, onComplete: @escaping (Character?) -> Void) {
        var url: String = ""
        
        if let page: String = page {
            url = "\(basePath)character/?page=\(page)"
        } else {
            url = "\(basePath)character/"
        }
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(Character?.self, from: data)
                onComplete(characters)
                
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
}
