//
//  RecipeDetailContract.swift
//  RecipeAppViper
//
//  Created by Ricardo on 27/07/2023.
//

import Foundation
import UIKit

protocol RecipeDetailRouterProtocol {
    static func createModule(recipeId: Int) -> UIViewController
    func goToRecipeMap(recipeId: Int)
    var viewController: UIViewController? {get set}
}

protocol RecipeDetailInteractorInputProtocol {
    func getRecipeDetail(for recipeId: Int)
}


protocol RecipeDetailInteractorOutputProtocol: AnyObject {
    func presentRecipeDetail(recipe: RecipeDetailEntity)
    func presentServiceError(_ error: Error)
}

protocol RecipeDetailViewProtocol: AnyObject {
    func onSearchResultsReceived()
    func displayServiceError(_ error: Error)
}

protocol RecipeDetailPresenterProtocol: AnyObject {
    var view: RecipeDetailViewProtocol? { get set }
    var recipeId: Int? { get set }
    var mapper: RecipeDetailMapper?{get set}
    var extendIngredientlMapper: ExtendedIngredientMapper?{get set}
    var interactor: RecipeDetailInteractorInputProtocol? {get set}
    var router: RecipeDetailRouterProtocol? {get set}
    
    func showRecipeDetail()
    func getRecipesCount() -> Int
    func getRecipes() -> [ExtendedIngredientViewModel]
    func getRecipesbyIndex(index: Int) -> ExtendedIngredientViewModel?
    func setupCurrentRecipe() -> RecipeDetailViewModel?
    func goToRecipeMap(index: Int)

}
