//
//  RecipeListRouter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 06/07/2023.
//

import Foundation
import UIKit

class RecipeSearchRouter: RecipeSearchRouterProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = RecipesSearchViewController()
        var presenter: RecipeSearchPresenterProtocol & RecipeSearchInteractorOutputProtocol = RecipeSearchPresenter()
        let interactor = RecipeSearchInteractor(serviceApi: ServiceAPI())
        var router: RecipeSearchRouterProtocol = RecipeSearchRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.mapper = RecipeSearchMapper()
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func goToRecipeDetail(recipeId: Int) {

        viewController?.navigationController?.pushViewController( RecipeDetailRouter.createModule(recipeId: recipeId), animated: true)
    }
}
