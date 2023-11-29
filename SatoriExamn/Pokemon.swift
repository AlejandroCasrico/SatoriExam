//
//  Pokemon.swift
//  SatoriExamn
//
//  Created by Alejandro Casillas  on 28/11/23.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct Pokemon: Codable {
    let name: String
    let sprites: Sprites

    struct Sprites: Codable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}



