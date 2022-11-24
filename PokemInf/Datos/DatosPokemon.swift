//
//  DatosPokemon.swift
//  PokemInf
//
//  Created by Victor Tejeda on 22/11/22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
    let weight: Int
    let height: Int
    
}
