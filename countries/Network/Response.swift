//
//  Response.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let data: T?
}

struct Country: Decodable{
    let code: String?
    let name: String?
}

struct CountryDetail: Decodable {
    let code: String?
    let flagImageUri: String?
    let name: String?
    let wikiDataId: String?
}

struct CustomError: Error {
    let message: String
}
