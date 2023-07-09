//
//  UIViewController+Alert.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 03/05/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alertView, animated: true, completion: nil)
    }
}
