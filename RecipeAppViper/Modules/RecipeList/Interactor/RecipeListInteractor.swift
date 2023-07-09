//
//  RecipeListInteractor.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 06/07/2023.
//

import Foundation

typealias FetchResultCallback<T> = (Result<T, Error>) -> Void

protocol RecipeListInteractorProtocol {
    func fetchRecipesList(query: String,  completion: @escaping (Result<RecipesListEntity, Error>) -> Void)
}

class RecipeListInteractor : RecipeListInteractorProtocol {
    var serviceApi : ServiceApiProtocol = ServiceAPI()
    func fetchRecipesList(query: String,  completion: @escaping (Result<RecipesListEntity, Error>) -> Void) {
        let urlString = Constants.host + Constants.RecipesSearchEndpoint + "query=\(query)" + "&" + Constants.apiKey
        serviceApi.sendRequest(of: RecipesListEntity.self, url: urlString, completion: completion)
    }
}
