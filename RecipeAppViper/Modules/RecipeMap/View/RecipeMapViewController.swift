//
//  ForecastViewController.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import UIKit
import MapKit

class RecipeMapViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    var presenter : RecipeMapPresenterProtocol?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.setupDelegates()
        self.prepareViews()
        presenter?.showRecipeMap()
        
    }
    
    // MARK: Setup Views
    func prepareViews() {
        activityIndicator.isHidden = true
    }
    
    func setupCurrentRecipe() {
        if let recipeMapViewModel = presenter?.getCurrentLocation() {
            mapView.addAnnotation(recipeMapViewModel)
            mapView.centerToLocation(CLLocation.init(latitude: recipeMapViewModel.coordinate.latitude, longitude: recipeMapViewModel.coordinate.longitude))
        }
        
    }
    
    
    func setupDelegates() {
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

extension RecipeMapViewController: RecipeMapViewProtocol {
    func onSearchResultsReceived() {
        DispatchQueue.main.async {
            self.hideLoading()
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
    
}


private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
