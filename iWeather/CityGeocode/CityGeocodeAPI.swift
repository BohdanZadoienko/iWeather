//
//  CityGeocodeAPI.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 12.07.23.
//

import Foundation


struct CityGeocodeAPI {
    
    enum CityGeocodeAPIError : Error{
        case badURL
    }
    
    func fetchCityGeocode(completionHandler: @escaping (Result<CityData, Error>) -> Void) {
        let cityUrlSrting = "https://geocoding-api.open-meteo.com/v1/search?name=Kothen&count=1&language=en"
        
        guard let url = URL(string: cityUrlSrting) else {
            completionHandler(.failure(CityGeocodeAPIError.badURL))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data,
               let city = try? JSONDecoder().decode(CityData.self, from: data) {

                completionHandler(.success(city))
            }
        }).resume()
    }
}
