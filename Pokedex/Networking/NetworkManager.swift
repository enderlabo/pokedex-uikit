//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Laborit on 31/07/21.
//

import Foundation

enum HttpMethodCases: String {
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case post = "POST"
}

enum PokemonApiResponse {
    case success(pokemon: [Pokemon])
    case failed
}

final class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var nextPokemonPage: URL?
    
    func getPokemons(callback: @escaping (PokemonApiResponse) -> Void){
        var urlComponent = URLComponents(string: baseUrl.absoluteString)
        urlComponent?.queryItems = [
        URLQueryItem(name: "limit", value: "6")
        ]
        
        let nextUrl = nextPokemonPage != nil ? nextPokemonPage : urlComponent?.url
        
        guard let url = nextUrl else {
            callback(.failed)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethodCases.get.rawValue
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
            
            if let error = error {
                print("Error fetching Pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                // parse the data from the server to our model
                let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
                
                if let nextPageUrl = response.next {
                    self.nextPokemonPage = URL(string: nextPageUrl)
                }
                // filter, map, flatmap, etc
                let names = response.results.map { result in
                    result.name ?? ""
                }
                self.getPokemons(withNames: names) { response in
                  callback(response)
                }
                
            } catch {
                print("Error decoding Pokemons \(error)")
                return
            }
            
        }.resume()
    }
    //MARK: - Get pokemons
    func getPokemons(withNames names: [String], callback: @escaping(PokemonApiResponse) -> Void) {
        // 1-DispatchGroup
        let dispatchGroup = DispatchGroup()
        var pokemons: [Pokemon] = []
        
        names.forEach { name in
            //2- When start the iteration to array
            dispatchGroup.enter()
            self.getPokemon(withName: name.lowercased()){ response in
                
                switch response {
                case .success(let resultPokemons) :
                    if let pokemon = resultPokemons.first {
                        pokemons.append(pokemon)
                    }
                    dispatchGroup.leave()
                    break
                    
                case .failed:
                    dispatchGroup.leave()
                    break
                }
            }
        }// Loop
        
        dispatchGroup.notify(queue: .main){
            callback(.success(pokemon: pokemons))
        }
    }
    
    //MARK: - To retrieve only 1 pokemon by name
    func getPokemon(withName: String, callback: @escaping (PokemonApiResponse) -> Void) {
        
        let requestURL = baseUrl.appendingPathComponent(withName + "/")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethodCases.get.rawValue
        
        URLSession.shared.dataTask(with: request){ (data, _ , error) in
            if let error = error {
                print("Error fetching Pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do{
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                callback(.success(pokemon: [pokemon]))
                
            } catch {
                print("Error decoding Pokemons: \(error)")
            }
        }.resume()
    }
    
}
