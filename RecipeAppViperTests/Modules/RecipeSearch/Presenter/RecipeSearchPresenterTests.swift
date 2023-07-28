//
//  RecipeSearchPresenterTests.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 27/07/2023.
//

import Foundation
import XCTest

@testable import RecipeAppViper
enum MyError: Error {
       case someExpectedError
       case someUnexpectedError
   }

class RecipeSearchPresenterTests: XCTestCase {

    var presenter: RecipeSearchPresenter!
    var view = RecipeSearchViewMock()
    var interactor = RecipeSearchInteractorMock()
    var router = RecipeSearchRouterMock()
    
    override func tearDown() {
        presenter = nil
    }
    
    override func setUp() {
        presenter = RecipeSearchPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.mapper = RecipeSearchMapper()
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    func testSearchProductNoFetch() {
        // Given When
        presenter.searchItems(query: "test")
        // Then
        XCTAssert(interactor.searchRecipesCalled)
    }
    
    func testSearchProduct() {
        // Given When
        presenter.searchItems(query: "test")
        // Then
        XCTAssert(interactor.searchRecipesCalled)
    }
    
    func testGoToProductDetail() {
        // Given
        presenter.presentRecipes(recipes: RecipeSearchMockData.recipesListEntity.recipes)
        // When
        presenter.goToRecipeDetail(index: 1)
        // Then
        XCTAssert(router.goToRecipeDetailCalled)
        XCTAssert(view.onSearchResultsReceivedCalled)
    }
    
    

    
    func testPresentServiceError() {
        presenter.presentServiceError(MyError.someExpectedError)
        XCTAssert(view.onSearchErrorCalled)
    }
}
