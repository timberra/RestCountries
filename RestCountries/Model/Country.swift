//
//  Country.swift
//  RestCountries
//
//  Created by liga.griezne on 16/11/2023.
//

import Foundation

struct Name:Codable{
    let common,official:String?

}

struct Country:Codable{
    let name:Name
    let capital: [String]?
    let region: String?
    let timezones: [String]?

    
}
