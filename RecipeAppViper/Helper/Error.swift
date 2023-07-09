//
//  Error.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation


enum StringError: Error {
    case nilValue
}

enum WeatherError: Error {
    case requestFailed
    case decodingFailed
}
