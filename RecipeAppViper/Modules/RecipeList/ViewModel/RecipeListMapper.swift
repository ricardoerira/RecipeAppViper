//
//  RecipeListMapper.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

struct RecipeListMapper {
    func map(entities:  [RecipeEntity]) ->  [RecipeViewModel] {
        return entities.map { entity in
               return RecipeViewModel(id: entity.id, title: entity.title, imageUrl: URL(string: entity.image))
           }
    }
}
