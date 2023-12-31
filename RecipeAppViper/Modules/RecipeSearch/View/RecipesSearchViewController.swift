//
//  ViewController.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 18/04/2023.
//

//  SearchPresenter.swift

import Foundation
import UIKit

class RecipesSearchViewController: UIViewController {
    @IBOutlet weak var recipesSearchBar: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter : RecipeSearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegates()
        self.setupTableViewDataSource()
        self.prepareViews()
    }
    
    // MARK: Setup Views
    func prepareViews() {
        recipesTableView.layer.cornerRadius = Constants.CornerRadius;
        recipesSearchBar.layer.cornerRadius = Constants.CornerRadius;
        activityIndicator.isHidden = true
        
        recipesTableView.register(
            UINib(nibName: Constants.ItemCellIdentifier, bundle: Bundle.main),
            forCellReuseIdentifier: Constants.ItemCellIdentifier)
    }
    
    func setupTableViewDataSource() {
        recipesTableView.dataSource = self
    }
    
    func setupDelegates() {
        recipesSearchBar.delegate = self
        recipesTableView.delegate = self
        presenter?.view = self
    }
    
    // MARK: Activity Indicator
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    @IBAction func searchPerform(_ sender: Any) {
        if let query = recipesSearchBar.text {
            if (!query.isEmpty) {
                clearTableView()
                showLoading()
                presenter?.searchItems(query: query)
            }
        }
    }
}

extension RecipesSearchViewController: RecipeSearchViewProtocol {
    
    func clearTableView() {
        recipesTableView.reloadData()
    }
    
    // MARK: Errors handlers
    func onSearchResultsReceived() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.recipesTableView.reloadData()
        }
    }
    
    func onSearchError(_ error: Error) {
        self.hideLoading()
        DispatchQueue.main.async {
            self.showAlert(title: NSLocalizedString("GENERAL_ERROR_TITLE",tableName: "Strings", comment: ""),message: NSLocalizedString( error.localizedDescription.description,tableName: "Strings", comment: ""))
        }
    }
    
    // MARK: Present Detail
    func onGoToDetailError(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: NSLocalizedString("GENERAL_ERROR_TITLE",tableName: "Strings", comment: ""),message: NSLocalizedString( error.localizedDescription,tableName: "Strings", comment: ""))
        }
    }
    
}

// MARK: UISearchBarDelegate
extension RecipesSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.presenter?.clearItems()
        }
        else  {
            clearTableView()
            showLoading()
            presenter?.searchItems(query: searchText)
        }
    }
}

// MARK: UITableViewDelegate  UITableViewDataSource 
extension RecipesSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToRecipeDetail(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ItemCellIdentifier, for: indexPath) as! RecipeCell
        
        if let item = self.presenter?.getItem(index: indexPath.row) {
            cell.setupCell(item)
        }
        return cell
    }
}

