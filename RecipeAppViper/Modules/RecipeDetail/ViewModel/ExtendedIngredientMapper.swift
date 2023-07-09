//
//  ExtendedIngredientMapper.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

struct ExtendedIngredientMapper {
    func map(entities:  [ExtendedIngredientEntity]) ->  [ExtendedIngredientViewModel] {
        return entities.map { entity in
            return ExtendedIngredientViewModel(id: entity.id, name: entity.name, amount: entity.amount, unit: entity.unit, image: entity.image)
           }
    }
}
