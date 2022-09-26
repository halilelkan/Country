//
//  FavoriteCountryTableViewCell.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 25.09.2022.
//

import UIKit

class FavoriteCountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var onActionFavoriteButton : (() -> Void)?
    
    func configurSaved(with country: Country) {
        countryNameLabel.text = country.name
        favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
    }
    
    @IBAction func favoriteActionButton(_ sender: Any) {
        self.onActionFavoriteButton?()
    }
}

