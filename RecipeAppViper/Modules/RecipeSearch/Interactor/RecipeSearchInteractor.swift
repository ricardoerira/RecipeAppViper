//
//  RecipeListInteractor.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 06/07/2023.
//

import Foundation

typealias FetchResultCallback<T> = (Result<T, Error>) -> Void


class RecipeSearchInteractor : RecipeSearchInteractorInputProtocol  {
    var serviceApi : ServiceApiProtocol
    weak var presenter: RecipeSearchInteractorOutputProtocol?

    init(serviceApi: ServiceApiProtocol = ServiceAPI()) {
        self.serviceApi = serviceApi
    }
    
    func searchRecipes(query: String) {
        let urlString = Constants.hostReicipe + Constants.RecipesSearchEndpoint + "query=\(query)" + "&" + Constants.apiKey
        serviceApi.sendRequest(of: RecipesListEntity.self, url: urlString) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let recipesResponse):
                self.presenter?.presentRecipes(recipes: recipesResponse.recipes)
            case .failure(let error):
                self.presenter?.presentServiceError(error)
            }
        }
    }
}
