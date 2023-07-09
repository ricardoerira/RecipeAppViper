//
//  RecipeDetailViewModel.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation


struct RecipeDetailViewModel {
    let id: Int
    let title: String
    let image: String
    let summary: String
    var extendedIngredients: [ExtendedIngredientViewModel]
}
