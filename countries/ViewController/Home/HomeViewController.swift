//
//  HomeViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var countryListTableView: UITableView!
    
    private var countries: [Country] = []
    var imageName:String = ""

    var favoriteList = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countryListTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")
        
        countryListTableView.delegate = self
        countryListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCountriesList()
        countries.removeAll()
    }
   
    
    func fetchCountriesList() {
        
        let network = Network()
        network.request(EndPointType: .countries) { (result: Result<BaseResponse<[Country]>, CustomError>) in
            
            switch result{
            case.success(let response):
                self.countries = response.data ?? []
                
                DispatchQueue.main.async {
                    self.countryListTableView.reloadData()
                }
                
            case.failure(let error):
                print(error.message)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        let country = countries[indexPath.row]
        let countryCode = country.code ?? ""
        
        if favoriteList.array(forKey: "favoriteListArray") != nil{
            
            let favoriteListArray = favoriteList.array(forKey: "favoriteListArray")
            let results = favoriteListArray!.filter { favoriteListArray in favoriteListArray as! String == countryCode }
            if results.count != 0 {
                imageName = "Favorite"
            }
            else{
                imageName = "UnFavorite"
            }
        } else {
            imageName = "UnFavorite"
            }
        cell.configurHome(with: country, imageName: imageName)
        cell.onActionFavoriteButton = {

            if var favoriteListArray = self.favoriteList.array(forKey: "favoriteListArray"){
                let results = favoriteListArray.filter { favoriteListArray in favoriteListArray as! String == countryCode }
                
                if results.count != 0 {
                    let a = favoriteListArray.firstIndex(where: {$0 as! String == countryCode})
                    favoriteListArray.remove(at: a!)
                    self.imageName = "UnFavorite"
                    self.favoriteList.set(favoriteListArray, forKey: "favoriteListArray")
                    
                } else {
                    favoriteListArray.append(countryCode)
                    self.imageName = "Favorite"
                    self.favoriteList.set(favoriteListArray, forKey: "favoriteListArray")
                }
                
                cell.configurHome(with: country, imageName: self.imageName)

            } else {
                var favoriteListArray = [String]()
                favoriteListArray.append(countryCode)
                self.favoriteList.set(favoriteListArray, forKey: "favoriteListArray")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let code = countries[indexPath.row].code ?? ""
        let coutryDetail = CountryDetailViewController(countryCode: code)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(coutryDetail, animated: true)
        }
    }
}
