//
//  MockServiceAPI.swift
//  RecipeAppViperTests
//
//  Created by Ricardo on 08/07/2023.
//

import Foundation

class MockServiceAPI: ServiceApiProtocol {
    func sendRequest<T: Decodable>(of type: T.Type, url: String, completion: @escaping FetchResultCallback<T>) {
        let mockResponse: [String: Any] = [
            "results": [
                [
                    "id": 12345,
                    "title": "Delicious Pasta Recipe",
                    "image": "https://spoonacular.com/recipeImages/654495-312x231.jpg"
                ],
                [
                    "id": 67890,
                    "title": "Creamy Pasta Carbonara",
                    "image": "https://spoonacular.com/recipeImages/654495-312x231.jpg"
                ]
            ],
            "totalResults": 2
        ]
        
        do {
            let responseData = try JSONSerialization.data(withJSONObject: mockResponse, options: [])
            let decoder = JSONDecoder()
            let entity = try decoder.decode(T.self, from: responseData)
            completion(.success(entity as! T))
        } catch {
            completion(.failure(error))
        }
        //        } else {
        //            let error = NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)
        //            completion(.failure(error))
        //        }
    }
}
