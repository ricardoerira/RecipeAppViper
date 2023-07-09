//
//  RecipeDetailInteractor.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

protocol RecipeDetailInteractorProtocol {
    func fetchRecipeDetailData(for recipeId: Int, completion: @escaping (Result<RecipeDetailEntity, Error>) -> Void)
}

class RecipeDetailInteractor : RecipeDetailInteractorProtocol {
    
    var serviceApi : ServiceApiProtocol = ServiceAPI()

    func fetchRecipeDetailData(for city: Int, completion: @escaping (Result<RecipeDetailEntity, Error>) -> Void) {
        let urlForecastString = Constants.host + "\(city)/" + Constants.RecipeDetailEndpoint + Constants.apiKey
        serviceApi.sendRequest(of: RecipeDetailEntity.self, url: urlForecastString, completion: completion)
    }
}

