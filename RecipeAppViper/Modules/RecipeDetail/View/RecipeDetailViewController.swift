//
//  ForecastViewController.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var presenter : RecipeDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.setupDelegates()
        self.setupTableViewDataSource()
        self.prepareViews()
        presenter?.showRecipeDetail()

    }
    
    @IBAction func goToMap(_ sender: Any) {
        presenter?.goToRecipeMap(index: 0)
    }
    // MARK: Setup Views
    func prepareViews() {
        ingredientsTableView.layer.cornerRadius = Constants.CornerRadius;
        summaryTextView.layer.cornerRadius = Constants.CornerRadius;
        activityIndicator.isHidden = true
        ingredientsTableView.register(
            UINib(nibName: Constants.IngredientsCellIdentifier, bundle: Bundle.main),
            forCellReuseIdentifier: Constants.IngredientsCellIdentifier)
    }
    
    func setupCurrentRecipe() {
        if let current = presenter?.setupCurrentRecipe() {
            titleLabel.text = current.title
            if let attributedString = current.summary.htmlToAttributedString {
                summaryTextView.attributedText = attributedString
                    }
        }
    }
    
    func setupTableViewDataSource() {
        ingredientsTableView.dataSource = self
    }
    
    func setupDelegates() {
        ingredientsTableView.delegate = self
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
    
}

extension RecipeDetailViewController: RecipeDetailViewProtocol {
    func onSearchResultsReceived() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.ingredientsTableView.reloadData()
            self.setupCurrentRecipe()
        }
    }
    
    func displayServiceError(_ error: Error) {
        self.hideLoading()
        DispatchQueue.main.async {
            self.showAlert(title: NSLocalizedString("GENERAL_ERROR_TITLE",tableName: "Strings", comment: ""),message: NSLocalizedString( error.localizedDescription,tableName: "Strings", comment: ""))
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func clearTableView() {
        ingredientsTableView.reloadData()
    }
   
}

// MARK: UITableViewDelegate  UITableViewDataSource
extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getRecipesCount() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IngredientsCellIdentifier, for: indexPath) as! IngredientsCell
        
        if let item = self.presenter?.getRecipesbyIndex(index: indexPath.row) {
            cell.setupCell(item)
        }
        return cell
    }
}
 
