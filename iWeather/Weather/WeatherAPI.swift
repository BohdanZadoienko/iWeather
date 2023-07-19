//
//  WeatherAPI.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 11.07.23.
//

import Foundation



struct WeatherAPI {
    
    
    enum WeatherAPIError : Error{
        case badUrl
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Result<WeatherData, Error>) -> Void) {
    
        let date = Date()
        let dateFormatter = DateFormatter()
        let dayFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        dayFormatter.dateFormat = "dd"
        let startDate = dateFormatter.string(from: date) + "-" + dayFormatter.string(from: date)
        let finishDate =  dateFormatter.string(from: date) + "-" + String((Int(dayFormatter.string(from: date)) ?? .zero) + 7)
        print("Start day:", startDate)
        print("Finish day:", finishDate)
        
        let urlSrting = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,relativehumidity_2m,dewpoint_2m,apparent_temperature,precipitation_probability,precipitation,rain,showers,snowfall,snow_depth,weathercode,pressure_msl,surface_pressure,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high,visibility,evapotranspiration,et0_fao_evapotranspiration,vapor_pressure_deficit,windspeed_10m,windspeed_80m,windspeed_120m,windspeed_180m,winddirection_10m,winddirection_80m,winddirection_120m,winddirection_180m,windgusts_10m,temperature_80m,temperature_120m,temperature_180m&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,uv_index_clear_sky_max,precipitation_sum,rain_sum,showers_sum,snowfall_sum,precipitation_hours,precipitation_probability_max,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant,shortwave_radiation_sum&current_weather=true&timezone=auto&start_date=\(startDate)&end_date=\(finishDate)"
        
        guard let url = URL(string: urlSrting) else {
            completionHandler(.failure(WeatherAPIError.badUrl))
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
               let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                completionHandler(.success(weather))
                
            }
        }).resume()
    }
}
