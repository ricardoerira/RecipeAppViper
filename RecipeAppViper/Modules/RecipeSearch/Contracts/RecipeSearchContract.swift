//
//  RecipeListContract.swift
//  RecipeAppViper
//
//  Created by Ricardo on 25/07/2023.
//

import Foundation
import UIKit

protocol RecipeSearchRouterProtocol {
    func goToRecipeDetail(recipeId: Int)
    var viewController: UIViewController? {get set}
    static func createModule()-> UIViewController
}

protocol RecipeSearchInteractorInputProtocol  {
    func searchRecipes(query: String)
}

protocol RecipeSearchInteractorOutputProtocol: AnyObject {
    func presentRecipes(recipes: [RecipeEntity])
    func presentServiceError(_ error: Error)
}

protocol RecipeSearchViewProtocol: AnyObject {
    func onSearchResultsReceived()
    func onSearchError(_ error: Error)
    func onGoToDetailError(_ error: Error)
    func clearTableView()
}

protocol RecipeSearchPresenterProtocol {
    var view: RecipeSearchViewProtocol? {get set}
    var mapper: RecipeSearchMapper?{get set}
    var interactor: RecipeSearchInteractorInputProtocol? {get set}
    var router: RecipeSearchRouterProtocol? {get set}
    func searchItems(query: String)
    func trimmingCharacters(query: String) -> String
    func clearItems()
    func getItemsCount() -> Int
    func getItems() -> [RecipeViewModel]
    func getItem(index: Int) -> RecipeViewModel?
    func getItemIdbyIndex(index: Int) throws -> Int
    func goToRecipeDetail(index: Int)
}





