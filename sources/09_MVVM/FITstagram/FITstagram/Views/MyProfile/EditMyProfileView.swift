//
//  EditMyProfileview.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 18.11.2023.
//

import SwiftUI

struct EditMyProfileView: View {
    @State var usernameText: String
    @State var image: Image?
    @State var isGalleryPickerPresented = false
    @State var isCameraPickerPresented = false
    
    var onSaveDismiss: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Spacer()
                
                Rectangle()
                    .fill(.quaternary)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        image?
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
                    .overlay {
                        HStack {
                            Button {
                                isGalleryPickerPresented = true
                            } label: {
                                Image(systemName: "photo")
                            }
                            
                            Button {
                                isCameraPickerPresented = true
                            } label: {
                                Image(systemName: "camera")
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                
                VStack(spacing: 8) {
                    Text("Uživatelské jméno")
                    
                    TextField(
                        text: $usernameText,
                        label: {
                            //                        Text("Uživatelské jméno")
                        }
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isGalleryPickerPresented) {
            
        }
        .fullScreenCover(isPresented: $isCameraPickerPresented) {
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onSaveDismiss(usernameText)
                } label: {
                    Text("Uložit")
                }
            }
        }
    }
}

#Preview {
    EditMyProfileView(usernameText: "John", onSaveDismiss: { _ in })
}
