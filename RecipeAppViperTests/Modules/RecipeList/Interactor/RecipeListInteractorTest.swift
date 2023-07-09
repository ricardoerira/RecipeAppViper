//
//  RecipeListInteractorTest.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import XCTest

class RecipeListInteractorTests: XCTestCase {
    var interactor: RecipeListInteractor!
    var mockServiceApi: MockServiceAPI!
    var mockRecipeListEntity: RecipesListEntity!


    override func setUp() {
        super.setUp()
        interactor = RecipeListInteractor()
        mockServiceApi = MockServiceAPI()
        interactor.serviceApi = mockServiceApi
        let mockRecipeEntity1 = RecipeEntity(id: 654495, title: "Pancakes", image: "https://spoonacular.com/recipeImages/654495-312x231.jpg")
        let mockRecipeEntity2 = RecipeEntity(id: 656663, title: "Pop Tart", image: "https://spoonacular.com/recipeImages/656663-312x231.jpg")
        let recipeEntityList : [RecipeEntity] = [mockRecipeEntity1, mockRecipeEntity2]
        mockRecipeListEntity = RecipesListEntity(recipes: recipeEntityList)
      
    }

    override func tearDown() {
        interactor = nil
        mockServiceApi = nil
        super.tearDown()
    }

    func testFetchRecipesList_Successful() {
        
        let query = "pasta"
        
        let expectation = XCTestExpectation(description: "Fetch recipes list")

        interactor.fetchRecipesList(query: query) { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result.recipes.count, 2)
            case .failure:
                XCTFail("Should not return an error")
            }
            expectation.fulfill()
        }

        
        wait(for: [expectation], timeout: 5.0)
    }
}
