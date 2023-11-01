//
//  RemoteImage.swift
//  FITstagram
//
//  Created by Igor Rosocha on 31.10.2023.
//

import SwiftUI

struct RemoteImage: View {
    
    // MARK: - Internal properties
    
    let url: URL
    
    // MARK: - Private properties
    
    @State private var image: Image?
    
    // MARK: - UI
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    // MARK: - Private helpers
    
    private func fetchImage() {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let uiImage = UIImage(data: data)
                
                if let uiImage {
                    DispatchQueue.main.async {
                        self.image = Image(uiImage: uiImage)
                    }
                }
            }
            catch {
                print("[ERROR]: ", error)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    RemoteImage(
        url: URL(string: "https://loremflickr.com/640/360")!
    )
}
