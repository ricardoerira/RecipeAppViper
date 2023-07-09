//
//  File.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

struct ExtendedIngredientEntity: Codable  {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
    let image: String
    
}
