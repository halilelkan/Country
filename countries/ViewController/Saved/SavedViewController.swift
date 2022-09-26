//
//  SavedViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import UIKit

class SavedViewController: UIViewController {
    
    let favoriteList = UserDefaults.standard
    
    @IBOutlet private weak var countryListTableView: UITableView!
    private var countries: [Country] = []
    private var savedList: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "FavoriteCountryTableViewCell", bundle: nil)
        countryListTableView.register(nib, forCellReuseIdentifier: "FavoriteCountryTableViewCell")
        
        countryListTableView.delegate = self
        countryListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCountriesList()
        savedList.removeAll()
        countryListTableView.reloadData()
    }
    
    private func fetchCountriesList(){
        
        let network = Network()
        network.request(EndPointType: .countries) { (result: Result<BaseResponse<[Country]>, CustomError>) in
            switch result{
            case.success(let response):
                self.countries = response.data ?? []
                if let favoriteListArray = self.favoriteList.array(forKey: "favoriteListArray"){
                    
                    let country = self.countries.count
                    for i in 0..<country{
                        let dd = self.countries[i]
                        
                        for j in favoriteListArray {
                            if "\(j)" == dd.code{
                                self.savedList.append(dd)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.countryListTableView.reloadData()
                }
        
            case.failure(let error):
                print(error.message)
            }
        }
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCountryTableViewCell", for: indexPath) as! FavoriteCountryTableViewCell
        
        let country = savedList[indexPath.row]
        cell.configurSaved(with: country)
        cell.onActionFavoriteButton = {
            var favoriteListArray = self.favoriteList.array(forKey: "favoriteListArray")
            favoriteListArray?.remove(at: indexPath.row)
            self.favoriteList.set(favoriteListArray, forKey: "favoriteListArray")
            cell.configurSaved(with: country)
            self.fetchCountriesList()
            self.savedList.removeAll()
            self.countryListTableView.reloadData()
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
