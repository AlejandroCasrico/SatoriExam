//
//  ContentView.swift
//  SatoriExamn
//
//  Created by Alejandro Casillas  on 28/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(height: UIScreen.main.bounds.height / 2)
                .offset(y: UIScreen.main.bounds.height / 4)

            VStack {
                Image("logo2")
                    .resizable()
                    .frame(width: 400, height: 80)

                Text("Pokedex")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.blue)
                    .lineLimit(1)
                Image("pok").resizable()
                    .frame(width: 25, height: 25)

                ZStack {
                    if let pokemonImage = viewModel.pokemonImage {
                        pokemonImage
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text(viewModel.pokemonName.capitalized)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                            .padding()
                            .offset(y: 150)
                    } else {
                        // Placeholder or loading indicator
                        Text("Loading...")
                    }
                }
                Button(action: {
                    viewModel.changeToRandomPokemon()
                }) {
                    Text("Cambiar Pokémon")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchPokemonList()
            viewModel.fetchPokemon()
            Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                viewModel.changeToRandomPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#Preview {
    ContentView()
        
    }
