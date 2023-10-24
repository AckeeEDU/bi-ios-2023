//
//  UserDetailView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 22.10.2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "person.crop.square")
                .resizable()
                .foregroundStyle(.pink)
                .frame(width: 100, height: 100)
                .symbolEffect(.pulse)
            
            Text(
                (user.firstName ?? "")
                + " "
                + (user.lastName ?? "")
            )
        }
    }
}

#Preview {
    UserDetailView(user: .userMockMe)
}
