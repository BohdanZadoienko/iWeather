//
//  CurrentLocationManager.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 13.07.23.
//

import Foundation
import CoreLocation

class CurrentLocationManager: NSObject, CLLocationManagerDelegate{
    static let shared = CurrentLocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getCurrentLocation(completition: @escaping ((CLLocation?) -> Void)) {
        self.completion = completition
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    public func resolveCurrentLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current){ placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            var name = ""

            if let cityName = place.locality {
                name += "\(cityName)"
            }

            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
