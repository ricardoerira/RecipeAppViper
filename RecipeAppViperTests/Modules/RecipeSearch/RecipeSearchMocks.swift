//
//  File.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 27/07/2023.
//

import Foundation

import XCTest
@testable import RecipeAppViper

class RecipeSearchRouterMock: RecipeSearchRouterProtocol {
    
    var viewController: UIViewController?
    var createdModuleCalled = false
    var goToRecipeDetailCalled = false
    
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    func goToRecipeDetail(recipeId: Int) {
        goToRecipeDetailCalled = true
    }
}

class RecipeSearchInteractorMock: RecipeSearchInteractorInputProtocol {
   
    
    var presenter: RecipeSearchInteractorOutputProtocol?
    var searchRecipesCalled = false

    func searchRecipes(query: String) {
        searchRecipesCalled = true
    }
}

class RecipeSearchViewMock: RecipeSearchViewProtocol {
    
    var presenter: RecipeSearchPresenterProtocol?
    var onSearchResultsReceivedCalled = false
    var onSearchErrorCalled = false
    var onGoToDetailErrorCalled = false
    var clearTableViewCalled = false
    
    func onSearchResultsReceived() {
        onSearchResultsReceivedCalled = true

    }
    
    func onSearchError(_ error: Error) {
        onSearchErrorCalled = true
    }
    
    func onGoToDetailError(_ error: Error) {
        onGoToDetailErrorCalled = true
    }
    
    func clearTableView() {
        clearTableViewCalled = true
    }
    
}

class RecipeSearchPresenterMock: RecipeSearchInteractorOutputProtocol {
    
    var presentRecipesCalled = false
    var presentServiceErrorCalled = false
    
    func presentRecipes(recipes: [RecipeEntity]) {
        presentRecipesCalled = true
    }
    
    func presentServiceError(_ error: Error) {
        presentServiceErrorCalled = true
    }
}

struct RecipeSearchMockData {
    static let recipeEntityOne = RecipeEntity(id: 1, title: "Causa Limeña", image: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=243f7f5bd3204161a72734a8bd5d1230")
    static let recipeEntityTwo = RecipeEntity(id: 2, title: "Ceviche", image: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=243f7f5bd3204161a72734a8bd5d1230")
    
    static let recipesListEntity = RecipesListEntity(recipes: [recipeEntityOne,recipeEntityTwo])

}
