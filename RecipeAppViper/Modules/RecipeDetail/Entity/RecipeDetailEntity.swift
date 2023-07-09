//
//  RecipeDetail.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation

struct RecipeDetailEntity: Codable  {
    let id: Int
    let title: String
    let image: String
    let summary: String
    let ingredients: [ExtendedIngredientEntity]
    
    enum CodingKeys : String, CodingKey {
        case id,title,image,summary
        case ingredients = "extendedIngredients"
    }
}









