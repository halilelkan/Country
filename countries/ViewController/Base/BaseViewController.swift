//
//  BaseViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 25.09.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var titleBarName = ""
    var favoriteList = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
     baseNavigationBarDesing()
    }
    
    func baseNavigationBarDesing(){
            let backButton = UIBarButtonItem(title: titleBarName, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButton
            navigationItem.backBarButtonItem?.tintColor = UIColor.black
            
            let cartButton = UIBarButtonItem(image: UIImage(named: "Favorite"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.favorite))
            cartButton.tintColor = UIColor.black
            navigationItem.rightBarButtonItem = cartButton
            
            let appearence = UINavigationBarAppearance()
            appearence.backgroundColor = UIColor.white
            navigationController?.navigationBar.standardAppearance = appearence
            navigationController?.navigationBar.compactAppearance = appearence
            navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    func configureNavigationBar(with title: String = "Details"){
        navigationItem.title = title
        titleBarName = title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc private func favorite(){
    }
}
