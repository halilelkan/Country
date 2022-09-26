//
//  ForMoreInformaitonViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 25.09.2022.
//

import UIKit

class ForMoreInformaitonViewController: BaseViewController {

   
    @IBOutlet weak var web: UIWebView!
    
    let WikiDataId:String
    
    init(wikiDataId: String){
        self.WikiDataId = wikiDataId 
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = "https://www.wikidata.org/wiki/"
        guard let url1 = URL(string: baseURL + WikiDataId) else{return}
        web.loadRequest(URLRequest(url: url1))
    }
}
