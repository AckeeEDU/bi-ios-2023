//
//  Onboardingview.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 22.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 24) {
                Button {
                    path.append("onboarding")
                } label: {
                    Text("Launch onboarding")
                }
                
                Text(String(path.count))
            }
            .navigationDestination(for: String.self) { string in
                destination
            }
            .navigationTitle("Onboarding")
        }
    }
    
    // MARK: - UI Components
    
    var destination: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                Button {
                    path.removeLast()
                } label: {
                    Text("Zpět")
                }
                .tint(.red)
                
                Button {
                    path.removeLast(path.count)
                } label: {
                    Text("Zavřít")
                }
                .tint(.orange)
                
                Button {
                    path.append("dalsi")
                } label: {
                    Text("Další")
                }
            }
            
            Text(String(path.count))
        }
    }
}

#Preview {
    OnboardingView()
}
