//
//  CityData.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 12.07.23.
//

import Foundation

struct CityData: Codable {
    let results: [CityInfo]
    let generationtimeMS: Double

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }
}

// MARK: - Result
struct CityInfo: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Int
    let featureCode, countryCode: String
    let admin1ID: Int
    let timezone: String
    let population: Int?
    let countryID: Int
    let country, admin1: String
    let admin2ID: Int?
    let admin2: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case admin1ID = "admin1_id"
        case timezone, population
        case countryID = "country_id"
        case country, admin1
        case admin2ID = "admin2_id"
        case admin2
    }
}
