//
//  ContentView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 10.10.2023.
//

import SwiftUI

struct PostView: View {
    
    // MARK: - Internal properties
    
    let post: Post
    var onCommentsTapped: (() -> Void)?
                           
    // MARK: - Private properties
    
    // To re-enforce the local nature of @State properties, Apple recommends you mark them as private
    @State private var isBookmarked = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            headerView
                .padding(.horizontal)
            
            if let photo = post.photos.first {
                RemoteImage(url: photo)
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: UIScreen.main.bounds.size.width,
                        height: 300
                    )
                    .clipped()
            }
            
            footerView
                .padding(.top, 2)
                .padding(.horizontal)
        }
        .tint(.pink) // Tint color is applied to all nested precedents
    }

    // MARK: - UI Components

    private var headerView: some View {
        HStack {
            NavigationLink(value: post.author) {
                Text(post.author.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.myForeground)
            }

            Spacer()

            Button(
                action: { print("ellipsis tapped!") },
                label: {
                    Image(systemName: "ellipsis")
                        .padding(.vertical, 4) // Increases the size of the button tap area
//                        .background(.red) // Uncomment to see the result
                }
            )
        }
    }

    private var footerView: some View {
        VStack(alignment: .leading, spacing: 16) {
            buttonsHorizontalView
                .frame(height: 24)

            footerTextsView
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
    }
    
    private var buttonsHorizontalView: some View {
        HStack(spacing: 16) {
            imageButton(iconName: "heart") {
                print($0 + " tapped!")
            }

            imageButton(iconName: "message") { _ in
                onCommentsTapped?()
            }

            imageButton(iconName: "paperplane") {
                print($0 + " tapped!")
            }

            Spacer()

            imageButton(
                iconName: isBookmarked ? "bookmark.fill" : "bookmark"
            ) { _ in
                isBookmarked.toggle()
            }
        }
    }

    private var footerTextsView: some View {
        VStack(alignment: .leading, spacing: 7) {
            NavigationLink(value: post.likes) {
                Text(String(post.likes) + " To se mi líbí!")
                    .fontWeight(.semibold)
                    .foregroundStyle(.myForeground)
            }

            Text(post.author.username)
                .fontWeight(.semibold)
            +
            Text(" " + post.text)

            Button {
                onCommentsTapped?()
            } label: {
                Text("Zobrazit komentáře (" + String(post.comments) + ")")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            }
        }
    }

    /// Returns button with a wrapped image for given system icon name
    /// - Parameters:
    ///   - name: Given system icon name
    ///   - action: Action which should be performed on tap
    ///
    /// - Note: `@escaping` - Tells the Swift compiler that we know
    /// the closure leaves the scope it was passed to, and that we're okay with that
    private func imageButton(
        iconName name: String,
        action: @escaping (String) -> Void
    ) -> some View {
        Button {
            action(name)
        } label: {
            Image(systemName: name)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PostView(post: .postMock)
    }
}
