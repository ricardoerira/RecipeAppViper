//
//  RecipeMapInteractor.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation

class RecipeMapInteractor : RecipeMapInteractorInputProtocol {
    
    let serviceApi : ServiceApiProtocol
    weak var presenter: RecipeMapInteractorOutputProtocol?
    
    init(serviceApi: ServiceApiProtocol = ServiceAPI()) {
        self.serviceApi = serviceApi
    }
    
    func getRecipeMap(for recipeId: Int) {
        let urlString = Constants.hostMap + Constants.RecipeMapEndpoint
        serviceApi.sendRequest(of: RecipeMapEntity.self, url: urlString) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let RecipeMapResponse):
                self.presenter?.presentRecipeMap(recipe: RecipeMapResponse)
            case .failure(let error):
                self.presenter?.presentServiceError(error)
                
            }
        }
    }
}

