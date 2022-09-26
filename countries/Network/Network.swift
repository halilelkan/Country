//
//  Network.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import Foundation
import Alamofire

struct Network {
    
    private var baseUrlString = "https://wft-geo-db.p.rapidapi.com/v1/geo"
    let header: HTTPHeaders = [
        "X-RapidAPI-Key" : "f47dac780fmsh2fb529ef38e6268p1b5cb0jsn9b3195d4ce54",
        "X-RapidAPI-Host" : "wft-geo-db.p.rapidapi.com"
    ]
    
    func request<T: Decodable>(EndPointType: EndPointType, completion: @escaping (Result<T, CustomError>)-> Void) {
        
        guard let url = URL(string: baseUrlString + EndPointType.endPoint) else {return}
        AF.request(url, method: .get, headers: header).response{
            response in
            guard let data = response.data else { completion(.failure(CustomError(message: "Gelen Response içerisinde data yok")))
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch let error{
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
        }
    }
}
