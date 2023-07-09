//
//  RecipeCell.swift
//
//
//  Created by Ricardo Erira on 05/07/2023.
//

import UIKit


final class RecipeCell: UITableViewCell {
    
  
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    static let identifier = "RecipeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func prepareForReuse() {
        setupCell()
    }

    private func setupCell() {
        self.layer.cornerRadius = 10;
        backgroundColor = UIColor.clear
        selectionStyle = .none
        titleLabel.text = Constants.emptyString
        recipeImageView.roundImageView()
    }
    
    func setupCell(_ model: RecipeViewModel) {
        titleLabel.text = model.title
        self.recipeImageView.kf.setImage(with: model.imageUrl)
        
    }
}
