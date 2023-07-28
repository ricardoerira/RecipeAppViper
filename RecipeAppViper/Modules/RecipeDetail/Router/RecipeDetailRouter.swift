//
//  RecipeDetailRouter.swift
//  RecipeAppViper
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import UIKit

class RecipeDetailRouter : RecipeDetailRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(recipeId: Int) -> UIViewController {
        let view = RecipeDetailViewController()
        let presenter: RecipeDetailPresenterProtocol & RecipeDetailInteractorOutputProtocol = RecipeDetailPresenter()
        let interactor = RecipeDetailInteractor(serviceApi: ServiceAPI())
        var router: RecipeDetailRouterProtocol = RecipeDetailRouter()
        presenter.mapper = RecipeDetailMapper()
        presenter.extendIngredientlMapper = ExtendedIngredientMapper()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.recipeId = recipeId
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToRecipeMap(recipeId: Int) {

        viewController?.navigationController?.pushViewController( RecipeMapRouter.createModule(recipeId: recipeId), animated: true)
    }
}
