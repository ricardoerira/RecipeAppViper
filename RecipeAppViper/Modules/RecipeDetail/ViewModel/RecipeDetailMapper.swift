//
//  RecipeDetailMapper.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

struct RecipeDetailMapper {
    func map(entity:  RecipeDetailEntity) -> RecipeDetailViewModel {
        return RecipeDetailViewModel(id: entity.id, title: entity.title, image: entity.image, summary: entity.summary, extendedIngredients: [])
    }
    
}
