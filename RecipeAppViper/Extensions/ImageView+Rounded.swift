//
//  ImageView+Rounded.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 06/07/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func roundImageView() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
