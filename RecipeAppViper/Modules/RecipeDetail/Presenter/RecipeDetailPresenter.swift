//
//  RecipeDetailPresenter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation

protocol RecipeDetailPresenterDelegate: AnyObject {
    func onSearchResultsReceived()
    func displayServiceError(_ error: Error)
}

protocol RecipeDetailPresentable: AnyObject {
    var delegate: RecipeDetailPresenterDelegate? { get set }
    var recipeId: Int? { get }
    func showRecipeDetail()
    func getRecipesCount() -> Int
    func getRecipes() -> [ExtendedIngredientViewModel]
    func getRecipesbyIndex(index: Int) -> ExtendedIngredientViewModel?
    func setupCurrentRecipe() -> RecipeDetailViewModel?
}


class RecipeDetailPresenter : RecipeDetailPresentable {
    var recipeId: Int?
    weak var delegate: RecipeDetailPresenterDelegate?
    private let itemService : ServiceApiProtocol = ServiceAPI()
    private let recipeDetailInteractor: RecipeDetailInteractor
    private var recipeDetailViewModel: RecipeDetailViewModel?
    private let recipeDetailMapper: RecipeDetailMapper
    private let extendIngredientlMapper: ExtendedIngredientMapper
    
    
    init(recipeId: Int,recipeDetailInteractor: RecipeDetailInteractor = RecipeDetailInteractor(), recipeDetailMapper: RecipeDetailMapper = RecipeDetailMapper(), ingredientsMapper: ExtendedIngredientMapper = ExtendedIngredientMapper()) {
        self.recipeId = recipeId
        self.recipeDetailInteractor = recipeDetailInteractor
        self.recipeDetailMapper = recipeDetailMapper
        self.extendIngredientlMapper = ingredientsMapper
    }
    
    func showRecipeDetail() {
        guard let cityName = recipeId else {
            return
        }
        
        recipeDetailInteractor.fetchRecipeDetailData(for: cityName) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let recipeDetailResponse):
                let models = recipeDetailResponse
                self.recipeDetailViewModel = self.recipeDetailMapper.map(entity: models)
                self.recipeDetailViewModel?.extendedIngredients = self.extendIngredientlMapper.map(entities: models.ingredients)
                self.delegate?.onSearchResultsReceived()
            case .failure(let error):
                self.delegate?.displayServiceError(error)
            }
        }
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
}
