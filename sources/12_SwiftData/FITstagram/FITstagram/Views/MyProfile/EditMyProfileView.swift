//
//  EditMyProfileview.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 18.11.2023.
//

import SwiftUI

// This should use ViewModel 😏
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
                        label: {}
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isGalleryPickerPresented) {
            // Gallery picker
            ImagePicker(
                sourceType: .photoLibrary,
                image: $image,
                isPresented: $isGalleryPickerPresented
            )
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .fullScreenCover(isPresented: $isCameraPickerPresented) {
            // Camera picker
            // `NSCameraUsageDescription` needs to be added to Info.plist
            ImagePicker(
                sourceType: .camera,
                image: $image,
                isPresented: $isCameraPickerPresented
            )
            .ignoresSafeArea(.all, edges: .all)
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

struct ImagePicker: UIViewControllerRepresentable {
    // When you want your view controller to coordinate with other SwiftUI views, you must provide a Coordinator instance to facilitate those interactions
    // NSObject - Base class of all UIKit objects
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: Image?
        @Binding var isPresented: Bool
        
        init(image: Binding<Image?>, isPresented: Binding<Bool>) {
            self._image = image
            self._isPresented = isPresented
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            guard let uiImage = info[.originalImage] as? UIImage else {
                return
            }
            image = Image(uiImage: uiImage)
            isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
    
    let sourceType: UIImagePickerController.SourceType
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        // Delegate methods can customize how an app responds to an event and to decide where work happens
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
        // UIImagePickerController from SwiftUI, we don't need this for our purposes
    }
    

    
    // SwiftUI calls this method before calling the makeUIViewController(context:) method
    func makeCoordinator() -> Coordinator {
        Coordinator(
            image: $image,
            isPresented: $isPresented
        )
    }
}

#Preview {
    EditMyProfileView(usernameText: "John", onSaveDismiss: { _ in })
}
