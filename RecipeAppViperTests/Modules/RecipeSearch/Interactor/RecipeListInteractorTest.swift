//
//  RecipeSearchInteractorTest.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import XCTest

class RecipeSearchInteractorTests: XCTestCase {
    var interactor: RecipeSearchInteractor!
    var mockServiceApi: MockServiceAPI!
    var mockRecipeListEntity: RecipesListEntity!
    
    
    override func setUp() {
        super.setUp()
        interactor = RecipeSearchInteractor()
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
                
        let expectation = XCTestExpectation(description: "Fetch recipes list")
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=243f7f5bd3204161a72734a8bd5d1230"
        
        mockServiceApi.sendRequest(of: RecipesListEntity.self, url: urlString) { result in
            switch result {
            case .success(let recipesResponse):
                XCTAssertEqual(recipesResponse.recipes.count, 2)
            case .failure(_):
                                XCTFail("Should not return an error")
            }
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    
}
