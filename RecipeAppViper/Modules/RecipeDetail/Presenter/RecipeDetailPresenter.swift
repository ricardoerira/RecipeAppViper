//
//  RecipeDetailPresenter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation

class RecipeDetailPresenter : RecipeDetailPresenterProtocol {
   
    
    var interactor: RecipeDetailInteractorInputProtocol?
    weak var view: RecipeDetailViewProtocol?
    var router: RecipeDetailRouterProtocol?
    private var recipeDetailViewModel: RecipeDetailViewModel?
    
    var mapper: RecipeDetailMapper?
    var extendIngredientlMapper: ExtendedIngredientMapper?
    var recipeId: Int?
    
    func showRecipeDetail() {
        guard let recipeId = recipeId else {
            return
        }
        
        interactor?.getRecipeDetail(for: recipeId)

    }
    
    func getRecipesCount() -> Int {
        guard let ingredients = self.recipeDetailViewModel?.extendedIngredients else {
            return 0
        }
        return ingredients.count
        
    }
    
    func getRecipes() -> [ExtendedIngredientViewModel] {
        guard let models = self.recipeDetailViewModel?.extendedIngredients else {
            return []
        }
        
        return models
    }
    
    func getRecipesbyIndex(index: Int) -> ExtendedIngredientViewModel? {
        if let items = self.recipeDetailViewModel?.extendedIngredients {
            if (items.indices.contains(index)) {
                return items[index]
            }
        }
        return nil
    }
    
    func setupCurrentRecipe() -> RecipeDetailViewModel? {
        return self.recipeDetailViewModel
    }
    
    func goToRecipeMap(index: Int) {
        router?.goToRecipeMap(recipeId: index)
    }
}



extension RecipeDetailPresenter : RecipeDetailInteractorOutputProtocol {
    func presentRecipeDetail(recipe: RecipeDetailEntity) {
        self.recipeDetailViewModel = self.mapper?.map(entity: recipe)
        self.recipeDetailViewModel?.extendedIngredients = self.extendIngredientlMapper?.map(entities: recipe.ingredients) ?? []
        self.view?.onSearchResultsReceived()
    }
    
    func presentServiceError(_ error: Error) {
        self.view?.displayServiceError(error)
    }
}
