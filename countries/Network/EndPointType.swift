//
//  EndPointType.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import Foundation

enum EndPointType {
    
    case countries
    case countryDetail(code: String)
    
    var endPoint: String {
        switch self {
        case .countries:
            return "/countries"
        case .countryDetail(let code):
            return "/countries/" + code
        }
    }
}
