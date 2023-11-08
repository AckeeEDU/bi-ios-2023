//
//  ContentView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PostsListView()
                .tabItem {
                    Label(
                        "Feed",
                        systemImage: "photo.on.rectangle"
                    )
                }
            
            OnboardingView()
                .tabItem {
                    Label(
                        "Onboarding",
                        systemImage: "questionmark.app"
                    )
                }
            
            MyProfileView()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person"
                    )
                }
        }
    }
}

#Preview {
    ContentView()
}
