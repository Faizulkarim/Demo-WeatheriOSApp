//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreLocation

class LocationManager {
    static func getLocationNameFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                completion(nil)
                return
            }
            
            var locationName = ""
            if let locality = placemark.locality {
                locationName += locality
            }
            if let administrativeArea = placemark.administrativeArea {
                if !locationName.isEmpty {
                    locationName += ", "
                }
                locationName += administrativeArea
            }
            if let countryCode = placemark.isoCountryCode {
                if !locationName.isEmpty {
                    locationName += ", "
                }
                locationName += countryCode
            }
            
            completion(locationName)
        }
    }
    
    static func getCoordinatesFromLocationName(locationName: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationName) { (placemarks, error) in
            if let error = error {
                print("Geocoding failed with error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("No coordinates found for location: \(locationName)")
                completion(nil)
                return
            }
            
            let coordinates = location.coordinate
            completion(coordinates)
        }
    }

}

