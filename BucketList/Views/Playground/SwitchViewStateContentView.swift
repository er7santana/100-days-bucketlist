//
//  SwitchViewStateContentView.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 06/08/24.
//

import SwiftUI

struct SwitchViewStateContentView: View {
    
    @State private var loadingState = LoadingState.failed
    
    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
        }
        .padding()
    }
}

#Preview {
    SwitchViewStateContentView()
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
