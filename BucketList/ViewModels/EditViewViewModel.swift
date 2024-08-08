//
//  EditViewViewModel.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 08/08/24.
//

import SwiftUI

extension EditView {
    
    @Observable
    class ViewModel {
        
        var location: Location
        var name: String
        var description: String
        
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            
            name = location.name
            description = location.description
        }
        
        func save(completion: @escaping(Location) -> Void) {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            completion(newLocation)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                //success - convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .success
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }
    }
    
}
