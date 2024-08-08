//
//  ContentViewViewModel.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 08/08/24.
//

import CoreLocation
import LocalAuthentication
import MapKit
import SwiftUI

enum MapOptions: String {
    case standard = "Standard"
    case hybrid = "Hybrid"
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        }
    }
}

extension ContentView {
    
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        let mapOptions = [MapOptions.standard, .hybrid]
        var selectedMapOption = MapOptions.standard
        
        init() {
            do {
                locations = try FileManager.read()
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                try FileManager.write(content: locations)
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(),
                                       name: "New Location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
    
}
