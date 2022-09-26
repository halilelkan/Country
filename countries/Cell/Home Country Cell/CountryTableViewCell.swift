//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet weak var favoriteActionButton: UIButton!
    
    var onActionFavoriteButton : (() -> Void)?
  
    func configurHome(with country: Country, imageName: String) {
        countryNameLabel.text = country.name
        favoriteActionButton.setImage(UIImage(named: imageName), for: .normal)
    }
    @IBAction func favoriteActionButonn(_ sender: Any) {
        self.onActionFavoriteButton?()
    }
}
