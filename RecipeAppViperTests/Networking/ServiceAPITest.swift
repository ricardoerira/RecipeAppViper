//
//  ServiceAPITest.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation
import XCTest

class ServiceAPITest: XCTestCase {
    
    var url : String = String()
    let apiManager = ServiceAPI()
    
    struct FakeResponse: Codable {
        let id: Int
        let name: String
    }
    override func setUpWithError() throws {
        self.url = "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=243f7f5bd3204161a72734a8bd5d1230"
    }
    
    
    func testSendRequest_SuccessResponse() {
        let expectation = XCTestExpectation(description: "Send request")
        let apiManager = ServiceAPI()
        apiManager.sendRequest(of: RecipesListEntity.self, url: self.url) {  result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.recipes.count > 0, true)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSendRequest_FailureDecodedResponse() {
        let expectation = XCTestExpectation(description: "Send request")
        apiManager.sendRequest(of: FakeResponse.self, url: self.url) { result in
            
            switch result {
            case .success(let response):
                XCTFail("Request succeeded, but expected failure. Response: \(response)")
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Response could not be decoded because of error:\nNo se pudo leer los datos porque no se encontraron.")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSendRequest_FailureServerResponse() {
        let expectation = XCTestExpectation(description: "Send request")
        let urlFakeResponse =  "https://api.example.com/endpoint"
        apiManager.sendRequest(of: FakeResponse.self, url: urlFakeResponse) { result in
            switch result {
            case .success(let response):
                XCTFail("Request succeeded, but expected failure. Response: \(response)")
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ("URLSessionTask failed with error: No se encontró ningún servidor con el nombre de host especificado.") )
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
