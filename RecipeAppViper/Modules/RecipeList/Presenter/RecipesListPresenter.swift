//
//  CityCitySearchPresenter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation


protocol RecipesSearchPresenterDelegate: AnyObject {
    func onSearchResultsReceived()
    func onSearchError(_ error: Error)
    func onGoToDetailError(_ error: Error)
    func clearTableView()
}

protocol RecipesSearchPresentable {
    var delegate: RecipesSearchPresenterDelegate? { get set }
    func searchItems(query: String)
    func trimmingCharacters(query: String) -> String
    func clearItems()
    func getItemsCount() -> Int
    func getItems() -> [RecipeViewModel]
    func getItem(index: Int) -> RecipeViewModel?
    func getItemIdbyIndex(index: Int) throws -> Int
    func goToRecipeDetail(index: Int)
}

class RecipesSearchPresenter : RecipesSearchPresentable {
    weak var delegate: RecipesSearchPresenterDelegate?
    private let recipeListInteractor: RecipeListInteractor
    private var recipesViewModel: [RecipeViewModel]?
    private let mapper: RecipeListMapper
    private let recipeListRouter: RecipeListRouterProtocol

    init(recipeListInteractor: RecipeListInteractor = RecipeListInteractor(), mapper: RecipeListMapper = RecipeListMapper(), recipeListRouter : RecipeListRouterProtocol) {
        self.recipeListInteractor = recipeListInteractor
        self.mapper = mapper
        self.recipeListRouter = recipeListRouter
    }
    
    func searchItems(query: String) {
        recipeListInteractor.fetchRecipesList(query: trimmingCharacters(query: query)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let recipesResponse):
                let models = recipesResponse.recipes
                self.recipesViewModel = self.mapper.map(entities: models)
                self.delegate?.onSearchResultsReceived()
            case .failure(let error):
                self.delegate?.onSearchError(error)
            }
        }
    }
    
    func trimmingCharacters(query: String) -> String {
        return query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func clearItems() {
        self.recipesViewModel = []
        self.delegate?.clearTableView()
    }
    
    func getItemsCount() -> Int {
        if let items = self.recipesViewModel {
            return items.count
        }
        else {
            return 0
        }
    }
    
    func getItems() -> [RecipeViewModel] {
        if let items = self.recipesViewModel {
            return items
        }
        return []
    }
    
    func getItem(index: Int) -> RecipeViewModel? {
        if let items = self.recipesViewModel {
            if (items.indices.contains(index)) {
                return items[index]
            }
        }
        return nil
    }
    
    func getItemIdbyIndex(index: Int) throws -> Int {
        guard let itemid = self.recipesViewModel?[index].id else {
            throw StringError.nilValue
        }
        
        return itemid
    }
    
    func goToRecipeDetail(index: Int) {
        do {
            let itemId = try self.getItemIdbyIndex(index: index)
            recipeListRouter.showRecipeDetail(recipeId: itemId)
            
        } catch {
            delegate?.onGoToDetailError(error)
        }
    }
}
