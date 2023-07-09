//
//  RecipeDetailRouter.swift
//  RecipeAppViper
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import UIKit

protocol RecipeDetailRouterProtocol {
    func showRecipeDetail(fromViewController: UIViewController, recipeId: Int)
}

class RecipeDetailRouter : RecipeDetailRouterProtocol {
    
    func showRecipeDetail(fromViewController: UIViewController, recipeId: Int) {
        let presenter = RecipeDetailPresenter(recipeId: recipeId, recipeDetailInteractor: RecipeDetailInteractor(), recipeDetailMapper: RecipeDetailMapper(), ingredientsMapper: ExtendedIngredientMapper())
        let view = RecipeDetailViewController(presenter: presenter)
        presenter.delegate = view
        fromViewController.present(view, animated: true)
    }
}
