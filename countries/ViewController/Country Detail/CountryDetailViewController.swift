//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 25.09.2022.
//

import UIKit
import Alamofire
import SDWebImage

class CountryDetailViewController: BaseViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var coutryCodeLabel: UILabel!
    
    private let code: String
    private var WikiDataId: String = ""
    private var itemBarName = ""
    init(countryCode: String){
        self.code = countryCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCountryDetail()
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
    }

    func fetchCountryDetail(){
        let network = Network()
        network.request(EndPointType: .countryDetail(code: code)) { (result:Result<BaseResponse<CountryDetail>,CustomError>) in
            switch result {
            case.success(let response):
              
                DispatchQueue.main.async {
                    self.coutryCodeLabel.text = response.data?.code
                    guard let imageUrl = response.data?.flagImageUri else {return}
                    let url = URL(string:imageUrl)
                    self.flagImageView.sd_setImage(with: url)
                    self.WikiDataId = response.data?.wikiDataId ?? ""
                    self.configureNavigationBar(with: response.data?.name ?? "Details")
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.activityIndicatorView.isHidden = true
                    }
                }
            case.failure(let error):
                print(error.message)
            }
        }
    }
 
    @IBAction func forMorInformationActionButton(_ sender: Any) {
        self.activityIndicatorView.stopAnimating()
        let WikiDataId = self.WikiDataId
        let forMoreInformationViewController = ForMoreInformaitonViewController(wikiDataId: WikiDataId)
        self.navigationController?.pushViewController(forMoreInformationViewController, animated: true)
    }
}
