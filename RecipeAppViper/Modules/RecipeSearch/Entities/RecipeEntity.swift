//
//  CityModel.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation


struct RecipesListEntity: Codable {
    let recipes: [RecipeEntity]
    enum CodingKeys : String, CodingKey {
        case recipes = "results"
    }
}



struct RecipeEntity:  Codable {
    let id: Int
    let title: String
    let image: String
}
