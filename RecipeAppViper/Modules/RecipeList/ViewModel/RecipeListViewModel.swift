//
//  RecipeListViewModel.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

struct RecipeListViewModel {
    var results: [RecipeEntity]
}

struct RecipeViewModel {
    let id: Int
    let title: String
    let imageUrl: URL?
}
