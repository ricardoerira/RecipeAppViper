//
//  RecipeMapContract.swift
//  RecipeAppViper
//
//  Created by Ricardo on 27/07/2023.
//

import Foundation
import UIKit

protocol RecipeMapRouterProtocol {
    static func createModule(recipeId: Int) -> UIViewController
    var viewController: UIViewController? {get set}
}

protocol RecipeMapInteractorInputProtocol {
    func getRecipeMap(for recipeId: Int)
}


protocol RecipeMapInteractorOutputProtocol: AnyObject {
    func presentRecipeMap(recipe: RecipeMapEntity)
    func presentServiceError(_ error: Error)
}

protocol RecipeMapViewProtocol: AnyObject {
    func onSearchResultsReceived()
    func displayServiceError(_ error: Error)
}

protocol RecipeMapPresenterProtocol: AnyObject {
    var view: RecipeMapViewProtocol? { get set }
    var recipeId: Int? { get set }
    var mapper: RecipeMapMapper?{get set}
    var interactor: RecipeMapInteractorInputProtocol? {get set}
    var router: RecipeMapRouterProtocol? {get set}

    func showRecipeMap()
    func getCurrentLocation() -> RecipeOriginAnnotation?
}
