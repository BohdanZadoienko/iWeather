//
//  WeatherCode.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 11.07.23.
//

import Foundation

enum WeatherCode: Int {
    
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    case fog = 45
    case depositingRimeFog = 48
    case lightDrizzle = 51
    case moderateDrizzle = 53
    case denseIntensityDrizzle = 55
    case lightFreezingDrizzle = 56
    case denseIntensityFreezingDrizzle = 57
    case slightRain = 61
    case moderateRain = 63
    case heavyIntensityRain = 65
    case lightFreezingRain = 66
    case heavyIntensityFreezingRain = 67
    case slightSnowFall = 71
    case moderateSnowFall = 73
    case heavyIntensitySnowFall = 75
    case snowGrains = 77
    case slightRainShower = 80
    case moderateRainShower = 81
    case violentRainShower = 82
    case slightSnowShower = 85
    case heavySnowShower = 86
    case thunderstorm = 95
    case slightHailThunderstorm = 96
    case heavyHailThunderstorm = 99
    
    
    var description : String{
        switch self {
        case .clearSky:
            return "Clear sky"
        case .mainlyClear:
            return "Mainly Clear"
        case .partlyCloudy:
            return "Partly Cloudy"
        case .overcast:
            return "Overcast"
        case .fog:
            return "Fog"
        case .depositingRimeFog:
            return "Depositing Rime Fog"
        case .lightDrizzle:
            return "Light Drizzle"
        case .moderateDrizzle:
            return "Moderate Drizzle"
        case .denseIntensityDrizzle:
            return "Dense Intensity Drizzle"
        case .lightFreezingDrizzle:
            return "Light Freezing Drizzle"
        case .denseIntensityFreezingDrizzle:
            return "Dense Intensity Freezing Drizzle"
        case .slightRain:
            return "Slight Rain"
        case .moderateRain:
            return "Moderate Rain"
        case .heavyIntensityRain:
            return "Heavy Intensity Rain"
        case .lightFreezingRain:
            return "Light Freezing Rain"
        case .heavyIntensityFreezingRain:
            return "Heavy Intensity Freezing Rain"
        case .slightSnowFall:
            return "Slight Snow Fall"
        case .moderateSnowFall:
            return "Moderate Snow Fall"
        case .heavyIntensitySnowFall:
            return "Heavy Intensity Snow Fall"
        case .snowGrains:
            return "Snow Grains"
        case .slightRainShower:
            return "Slight Rain"
        case .moderateRainShower:
            return "Moderate Rain"
        case .violentRainShower:
            return "Violent Rain"
        case .slightSnowShower:
            return "Slight Snow Shower"
        case .heavySnowShower:
            return "Heavy Snow Shower"
        case .thunderstorm:
            return "Thunderstorm"
        case .slightHailThunderstorm:
            return "Slight Hail Thunderstorm"
        case .heavyHailThunderstorm:
            return "Heavy Hail Thunderstorm"
        }
    }
    
    var iconPath: String{
        switch self{
        case .clearSky:
            return "clear"
        case .mainlyClear:
            return "partlyCloud"
        case .partlyCloudy:
            return "partlyCloud"
        case .overcast:
            return "cloudy"
        case .fog:
            return "fog"
        case .depositingRimeFog:
            return "haze"
        case .lightDrizzle:
            return "drizzle"
        case .moderateDrizzle:
            return "rain"
        case .denseIntensityDrizzle:
            return "drizzle"
        case .lightFreezingDrizzle:
            return "freezingRain"
        case .denseIntensityFreezingDrizzle:
            return "freezingRain"
        case .slightRain:
            return "drizzle"
        case .moderateRain:
            return "rain"
        case .heavyIntensityRain:
            return "heavyRain"
        case .lightFreezingRain:
            return "freezingRain"
        case .heavyIntensityFreezingRain:
            return "freezingRain"
        case .slightSnowFall:
            return "snow"
        case .moderateSnowFall:
            return "heavySnow"
        case .heavyIntensitySnowFall:
            return "heavySnow"
        case .snowGrains:
            return "freezingRain"
        case .slightRainShower:
            return "drizzle"
        case .moderateRainShower:
            return "rain"
        case .violentRainShower:
            return "heavyRain"
        case .slightSnowShower:
            return "heavySnow"
        case .heavySnowShower:
            return "heavySnow"
        case .thunderstorm:
            return "thunderstorm"
        case .slightHailThunderstorm:
            return "thunderstorm"
        case .heavyHailThunderstorm:
            return "thunderstorm"
        }
    }
        var videoPath: String{
            switch self{
            case .clearSky:
                return "clearSky"
            case .mainlyClear:
                return "mainlyClear"
            case .partlyCloudy:
                return "mainlyClear"
            case .overcast:
                return "overcast"
            case .fog:
                return "fog"
            case .depositingRimeFog:
                return "haze"
            case .lightDrizzle:
                return "drizzle"
            case .moderateDrizzle:
                return "drizzle"
            case .denseIntensityDrizzle:
                return "drizzle"
            case .lightFreezingDrizzle:
                return "drizzle"
            case .denseIntensityFreezingDrizzle:
                return "drizzle"
            case .slightRain:
                return "drizzle"
            case .moderateRain:
                return "drizzle"
            case .heavyIntensityRain:
                return "drizzle"
            case .lightFreezingRain:
                return "drizzle"
            case .heavyIntensityFreezingRain:
                return "drizzle"
            case .slightSnowFall:
                return "slightSnowFall"
            case .moderateSnowFall:
                return "moderateSnowFall"
            case .heavyIntensitySnowFall:
                return "moderateSnowFall"
            case .snowGrains:
                return "moderateSnowFall"
            case .slightRainShower:
                return "drizzle"
            case .moderateRainShower:
                return "drizzle"
            case .violentRainShower:
                return "drizzle"
            case .slightSnowShower:
                return "moderateSnowFall"
            case .heavySnowShower:
                return "moderateSnowFall"
            case .thunderstorm:
                return "thunderstorm"
            case .slightHailThunderstorm:
                return "thunderstorm"
            case .heavyHailThunderstorm:
                return "thunderstorm"
            }
            
            
        }
        
    }
    
