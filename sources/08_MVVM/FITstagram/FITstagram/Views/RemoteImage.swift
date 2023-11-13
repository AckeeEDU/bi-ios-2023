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
                .task {
                    await fetchImage()
                }
        }
    }
    
    // MARK: - Private helpers
    
    @MainActor
    private func fetchImage() async {
        let downloadImage = Task.detached {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        
        do {
            if let uiImage = try await downloadImage.value {
                self.image = Image(uiImage: uiImage)
            }
        }
        catch {
            print("[ERROR]: ", error)
        }
    }
}

// MARK: - Previews

#Preview {
    RemoteImage(
        url: URL(string: "https://loremflickr.com/640/360")!
    )
}
