//
//  WeatherData.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 11.07.23.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Decodable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentWeather: CurrentWeather
    let hourlyUnits: HourlyUnits
    let hourly: Hourly
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Decodable {
    let temperature, windspeed: Double
    let winddirection, weathercode, isDay: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case temperature, windspeed, winddirection, weathercode
        case isDay = "is_day"
        case time
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let time: [String]
    let weathercode: [Int]
    let temperature2MMax, temperature2MMin, apparentTemperatureMax, apparentTemperatureMin: [Double]
    let sunrise, sunset: [String]
    let uvIndexMax, uvIndexClearSkyMax, precipitationSum, rainSum: [Double]
    let showersSum: [Double]
    let snowfallSum, precipitationHours, precipitationProbabilityMax: [Int]
    let windspeed10MMax, windgusts10MMax: [Double]
    let winddirection10MDominant: [Int]
    let shortwaveRadiationSum: [Double]

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case apparentTemperatureMax = "apparent_temperature_max"
        case apparentTemperatureMin = "apparent_temperature_min"
        case sunrise, sunset
        case uvIndexMax = "uv_index_max"
        case uvIndexClearSkyMax = "uv_index_clear_sky_max"
        case precipitationSum = "precipitation_sum"
        case rainSum = "rain_sum"
        case showersSum = "showers_sum"
        case snowfallSum = "snowfall_sum"
        case precipitationHours = "precipitation_hours"
        case precipitationProbabilityMax = "precipitation_probability_max"
        case windspeed10MMax = "windspeed_10m_max"
        case windgusts10MMax = "windgusts_10m_max"
        case winddirection10MDominant = "winddirection_10m_dominant"
        case shortwaveRadiationSum = "shortwave_radiation_sum"
    }
}

extension Daily {
    var dateFormated: [String] {
        var datesFormated = [Date]()
        var datesResult = [String]()
        
        let initialDateFormatter = DateFormatter()
        initialDateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in time {
            let date = initialDateFormatter.date(from: i)!
            datesFormated.append(date)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd "
        
        for date in datesFormated {
            datesResult.append(dateFormatter.string(from: date))
        }
        return datesResult
    }
    
}

// MARK: - DailyUnits
struct DailyUnits: Decodable {
    let time, weathercode, temperature2MMax, temperature2MMin: String
    let apparentTemperatureMax, apparentTemperatureMin, sunrise, sunset: String
    let uvIndexMax, uvIndexClearSkyMax, precipitationSum, rainSum: String
    let showersSum, snowfallSum, precipitationHours, precipitationProbabilityMax: String
    let windspeed10MMax, windgusts10MMax, winddirection10MDominant, shortwaveRadiationSum: String

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case apparentTemperatureMax = "apparent_temperature_max"
        case apparentTemperatureMin = "apparent_temperature_min"
        case sunrise, sunset
        case uvIndexMax = "uv_index_max"
        case uvIndexClearSkyMax = "uv_index_clear_sky_max"
        case precipitationSum = "precipitation_sum"
        case rainSum = "rain_sum"
        case showersSum = "showers_sum"
        case snowfallSum = "snowfall_sum"
        case precipitationHours = "precipitation_hours"
        case precipitationProbabilityMax = "precipitation_probability_max"
        case windspeed10MMax = "windspeed_10m_max"
        case windgusts10MMax = "windgusts_10m_max"
        case winddirection10MDominant = "winddirection_10m_dominant"
        case shortwaveRadiationSum = "shortwave_radiation_sum"
    }
}

// MARK: - Hourly
struct Hourly: Decodable {
    let time: [String]
    let temperature2M: [Double]
    let relativehumidity2M: [Int]
    let dewpoint2M, apparentTemperature: [Double]
    let precipitationProbability: [Int]
    let precipitation, rain, showers: [Double]
    let snowfall, snowDepth, weathercode: [Int]
    let pressureMsl, surfacePressure: [Double]
    let cloudcover, cloudcoverLow, cloudcoverMid, cloudcoverHigh: [Int]
    let visibility: [Int]
    let evapotranspiration, et0FaoEvapotranspiration, vaporPressureDeficit, windspeed10M: [Double]
    let windspeed80M, windspeed120M: [Double]
    let windspeed180M: [Double?]
    let winddirection10M, winddirection80M, winddirection120M: [Int]
    let winddirection180M: [Int?]
    let windgusts10M, temperature80M, temperature120M: [Double]
    let temperature180M: [Double?]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case dewpoint2M = "dewpoint_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitationProbability = "precipitation_probability"
        case precipitation, rain, showers, snowfall
        case snowDepth = "snow_depth"
        case weathercode
        case pressureMsl = "pressure_msl"
        case surfacePressure = "surface_pressure"
        case cloudcover
        case cloudcoverLow = "cloudcover_low"
        case cloudcoverMid = "cloudcover_mid"
        case cloudcoverHigh = "cloudcover_high"
        case visibility, evapotranspiration
        case et0FaoEvapotranspiration = "et0_fao_evapotranspiration"
        case vaporPressureDeficit = "vapor_pressure_deficit"
        case windspeed10M = "windspeed_10m"
        case windspeed80M = "windspeed_80m"
        case windspeed120M = "windspeed_120m"
        case windspeed180M = "windspeed_180m"
        case winddirection10M = "winddirection_10m"
        case winddirection80M = "winddirection_80m"
        case winddirection120M = "winddirection_120m"
        case winddirection180M = "winddirection_180m"
        case windgusts10M = "windgusts_10m"
        case temperature80M = "temperature_80m"
        case temperature120M = "temperature_120m"
        case temperature180M = "temperature_180m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Decodable {
    let time, temperature2M, relativehumidity2M, dewpoint2M: String
    let apparentTemperature, precipitationProbability, precipitation, rain: String
    let showers, snowfall, snowDepth, weathercode: String
    let pressureMsl, surfacePressure, cloudcover, cloudcoverLow: String
    let cloudcoverMid, cloudcoverHigh, visibility, evapotranspiration: String
    let et0FaoEvapotranspiration, vaporPressureDeficit, windspeed10M, windspeed80M: String
    let windspeed120M, windspeed180M, winddirection10M, winddirection80M: String
    let winddirection120M, winddirection180M, windgusts10M, temperature80M: String
    let temperature120M, temperature180M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case dewpoint2M = "dewpoint_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitationProbability = "precipitation_probability"
        case precipitation, rain, showers, snowfall
        case snowDepth = "snow_depth"
        case weathercode
        case pressureMsl = "pressure_msl"
        case surfacePressure = "surface_pressure"
        case cloudcover
        case cloudcoverLow = "cloudcover_low"
        case cloudcoverMid = "cloudcover_mid"
        case cloudcoverHigh = "cloudcover_high"
        case visibility, evapotranspiration
        case et0FaoEvapotranspiration = "et0_fao_evapotranspiration"
        case vaporPressureDeficit = "vapor_pressure_deficit"
        case windspeed10M = "windspeed_10m"
        case windspeed80M = "windspeed_80m"
        case windspeed120M = "windspeed_120m"
        case windspeed180M = "windspeed_180m"
        case winddirection10M = "winddirection_10m"
        case winddirection80M = "winddirection_80m"
        case winddirection120M = "winddirection_120m"
        case winddirection180M = "winddirection_180m"
        case windgusts10M = "windgusts_10m"
        case temperature80M = "temperature_80m"
        case temperature120M = "temperature_120m"
        case temperature180M = "temperature_180m"
    }
}
