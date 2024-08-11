//
//  ContentView.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 06/08/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .topTrailing) {
                MapReader { proxy in
//                    Map(initialPosition: startPosition) {
                    Map(position: $viewModel.currentPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.selectedMapOption.mapStyle)
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                }
                
                HStack {
                    Picker("Map options", selection: $viewModel.selectedMapOption) {
                        ForEach(viewModel.mapOptions, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
            }
            .onAppear() {
                viewModel.fetchUserLocation()
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
