//
//  ModelBreed.swift
//  Davaleba26
//
//  Created by Lika Nozadze on 11/27/23.
//


import Foundation


struct BreedResults: Decodable {
    let data: [breedFact]
}

struct breedFact: Decodable {
    let breed: String
}

