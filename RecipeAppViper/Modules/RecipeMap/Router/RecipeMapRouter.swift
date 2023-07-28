//
//  RecipeMapRouter.swift
//  RecipeAppViper
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import UIKit

class RecipeMapRouter : RecipeMapRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(recipeId: Int) -> UIViewController {
        let view = RecipeMapViewController()
        let presenter: RecipeMapPresenterProtocol & RecipeMapInteractorOutputProtocol = RecipeMapPresenter()
        let interactor = RecipeMapInteractor(serviceApi: ServiceAPI())
        var router: RecipeMapRouterProtocol = RecipeMapRouter()
        presenter.mapper = RecipeMapMapper()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.recipeId = recipeId
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
   
}
