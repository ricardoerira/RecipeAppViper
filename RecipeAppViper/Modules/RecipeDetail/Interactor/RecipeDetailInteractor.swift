//
//  RecipeDetailInteractor.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

class RecipeDetailInteractor : RecipeDetailInteractorInputProtocol {
    
    let serviceApi : ServiceApiProtocol
    weak var presenter: RecipeDetailInteractorOutputProtocol?
    
    init(serviceApi: ServiceApiProtocol = ServiceAPI()) {
        self.serviceApi = serviceApi
    }
    
    func getRecipeDetail(for recipeId: Int) {
        let urlString = Constants.hostReicipe + "\(recipeId)/" + Constants.RecipeDetailEndpoint + Constants.apiKey
        serviceApi.sendRequest(of: RecipeDetailEntity.self, url: urlString) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let recipeDetailResponse):
                self.presenter?.presentRecipeDetail(recipe: recipeDetailResponse)
            case .failure(let error):
                self.presenter?.presentServiceError(error)
                
            }
        }
    }
}

