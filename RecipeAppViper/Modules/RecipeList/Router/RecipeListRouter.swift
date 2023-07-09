//
//  RecipeListRouter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 06/07/2023.
//

import Foundation
import UIKit

protocol RecipeListRouterProtocol {
    var recipeDetailRouter: RecipeDetailRouter? { get }
    var recipesSearchViewController : RecipesSearchViewController? { get }
    func showRecipeList(window: UIWindow?)
    func showRecipeDetail(recipeId: Int)
}

class RecipeListRouter: RecipeListRouterProtocol {
    var recipeDetailRouter: RecipeDetailRouter?
    var recipesSearchViewController : RecipesSearchViewController?
    func showRecipeList(window: UIWindow?) {
        self.recipeDetailRouter = RecipeDetailRouter()
        let interactor = RecipeListInteractor()
        let presenter = RecipesSearchPresenter(recipeListInteractor: interactor, recipeListRouter: self)
        recipesSearchViewController = RecipesSearchViewController(presenter: presenter)
        presenter.delegate = recipesSearchViewController
        window?.rootViewController = recipesSearchViewController
        window?.makeKeyAndVisible()
    }
    
    func showRecipeDetail(recipeId: Int) {
        guard let vc = recipesSearchViewController else {
            return
        }
        
        recipeDetailRouter?.showRecipeDetail(fromViewController: vc, recipeId: recipeId)
    }
}
