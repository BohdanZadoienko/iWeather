//
//  LocationManager.swift
//  GeoLocation
//
//  Created by Bohdan Zadoienko on 12.07.23.
//

import Foundation
import CoreLocation


struct Location {
    let city: String?
    let title: String
    let coordinates: CLLocationCoordinate2D?
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) {places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models : [Location] = places.compactMap({ place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                
                let result = Location(
                    city: place.name,
                    title: name,
                    coordinates: place.location?.coordinate
                )
                return result
                
                
            })
            completion(models)
        }
    }
    
}

