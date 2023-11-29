//
//  pokemonManager.swift
//  SatoriExamn
//
//  Created by Alejandro Casillas  on 28/11/23.
//

import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemonName = "pikachu"
    @Published var pokemonImage: Image? = nil
    @Published var pokemonList: [PokemonListItem] = []
    @Published var selectedPokemon: Pokemon?

    func fetchPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName.lowercased())") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching Pokemon data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                if let spriteURL = URL(string: "\(pokemon.sprites.frontDefault)?\(UUID().uuidString)"),
                   let imageData = try? Data(contentsOf: spriteURL),
                   let uiImage = UIImage(data: imageData) {
                    let image = Image(uiImage: uiImage)
                    DispatchQueue.main.async {
                        self.pokemonImage = image
                    }
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
            }
        }.resume()
    }

    func fetchPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching Pokemon list: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonList = pokemonListResponse.results
                }
            } catch {
                print("Error decoding Pokemon list: \(error)")
            }
        }.resume()
    }

    func changeToRandomPokemon() {
        guard !pokemonList.isEmpty else {
            print("Pokemon list is empty.")
            return
        }

        if let randomPokemon = pokemonList.randomElement() {
            pokemonName = randomPokemon.name
            fetchPokemon()
        }
    }
}
