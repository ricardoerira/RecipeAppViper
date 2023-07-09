//
//  ItemService.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation
import Alamofire

protocol ServiceApiProtocol {
    func sendRequest<T: Decodable>(of type: T.Type, url: String, completion: @escaping FetchResultCallback<T>)
}
class ServiceAPI : ServiceApiProtocol {
    
    func sendRequest<T: Decodable>(of type: T.Type, url: String, completion: @escaping FetchResultCallback<T>) {
        AF.request(url).responseDecodable(of: T.self) { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            if let locations = response.value {
                completion(.success(locations))
            } else {
                completion(.failure(WeatherError.decodingFailed))
            }
        }
    }
}
