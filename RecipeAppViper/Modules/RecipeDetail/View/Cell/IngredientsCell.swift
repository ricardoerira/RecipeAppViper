//
//  IngredientsCell.swift
//
//
//  Created by Ricardo Erira on 05/07/2023.
//

import UIKit
import Kingfisher

final class IngredientsCell: UITableViewCell {
 
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        setupView()
    }
    
    // MARK: Setup Views
    private func setupView() {
        self.layer.cornerRadius = 10;
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    // MARK: Setup Data
    func setupCell(_ model: ExtendedIngredientViewModel) {
        self.lowTempLabel.text = String(model.amount)
        self.highTempLabel.text = String(model.unit)
        self.dayLabel.text = model.name.capitalized
     
    }
}
