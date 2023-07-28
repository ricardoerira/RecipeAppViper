//
//  RecipeMapPresenter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation

class RecipeMapPresenter : RecipeMapPresenterProtocol {
    var interactor: RecipeMapInteractorInputProtocol?
    weak var view: RecipeMapViewProtocol?
    var router: RecipeMapRouterProtocol?
    private var recipeMapViewModel: RecipeOriginAnnotation?
    
    var mapper: RecipeMapMapper?
    var extendIngredientlMapper: ExtendedIngredientMapper?
    var recipeId: Int?
    
    func showRecipeMap() {
        guard let recipeId = recipeId else {
            return
        }
        
        interactor?.getRecipeMap(for: recipeId)
    }
    
    func getCurrentLocation() -> RecipeOriginAnnotation? {
        return self.recipeMapViewModel
    }
}



extension RecipeMapPresenter : RecipeMapInteractorOutputProtocol {
    func presentRecipeMap(recipe: RecipeMapEntity) {
        self.recipeMapViewModel = self.mapper?.map(entity: recipe)
        self.view?.onSearchResultsReceived()
    }
    
    func presentServiceError(_ error: Error) {
        self.view?.displayServiceError(error)
    }
}
