//
//  CityCitySearchPresenter.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation

class RecipeSearchPresenter : RecipeSearchPresenterProtocol {
    var interactor: RecipeSearchInteractorInputProtocol?
    var router: RecipeSearchRouterProtocol?
    var mapper: RecipeSearchMapper?
    private var recipesViewModel: [RecipeViewModel]?
    weak var view: RecipeSearchViewProtocol?

    func searchItems(query: String) {
        interactor?.searchRecipes(query: query)
    }
    
    func trimmingCharacters(query: String) -> String {
        return query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func clearItems() {
        self.recipesViewModel = []
        self.view?.clearTableView()
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
            router?.goToRecipeDetail(recipeId: itemId)
            
        } catch {
            view?.onGoToDetailError(error)
        }
    }
}



extension RecipeSearchPresenter : RecipeSearchInteractorOutputProtocol {
    func presentRecipes(recipes: [RecipeEntity]) {
        self.recipesViewModel = self.mapper?.map(entities: recipes)
        self.view?.onSearchResultsReceived()
    }
    
    func presentServiceError(_ error: Error) {
        self.view?.onSearchError(error)
    }
}
