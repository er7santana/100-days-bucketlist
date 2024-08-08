//
//  EditView.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 07/08/24.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @State var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping(Location) -> Void) {
        
        self.onSave = onSave
        
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .success:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    
                    viewModel.save { newLocation in
                        onSave(newLocation)
                        dismiss()
                    }
                    
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
}

#Preview {
    EditView(location: .example) { _ in }
}
