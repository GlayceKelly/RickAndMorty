//
//  Episodies.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 26/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import Foundation

struct Episodies: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
