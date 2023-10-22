//
//  Onboardingview.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 22.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 24) {
            Button {
                
            } label: {
                Text("Launch onboarding")
            }
            
            Text(String("path.count"))
        }
    }
    
    var destination: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                Button {
                    
                } label: {
                    Text("Zpět")
                }
                .tint(.red)
                
                Button {
                    
                } label: {
                    Text("Zavřít")
                }
                .tint(.orange)
                
                Button {
                    
                } label: {
                    Text("Další")
                }
            }
            
            Text(String(""))
        }
    }
}

#Preview {
    OnboardingView()
}
