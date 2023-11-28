//
//  ContentView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 10.10.2023.
//

import SwiftUI

struct PostView: View {
    let viewModel: PostViewModel

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            headerView
                .padding(.horizontal)
            
            if let photo = viewModel.post.photos.first {
                NavigationLink(value: viewModel.post) {
                    RemoteImage(url: photo)
                        .frame(
                            width: UIScreen.main.bounds.size.width,
                            height: 300
                        )
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }
            
            footerView
                .padding(.top, 2)
                .padding(.horizontal)
        }
    }

    // MARK: - UI Components

    private var headerView: some View {
        HStack {
            NavigationLink(value: viewModel.post.author) {
                Text(viewModel.post.author.username)
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
            imageButton(iconName: viewModel.isLiked ? "heart.fill" : "heart") { _ in
                viewModel.likePost()
            }

            imageButton(iconName: "message") { _ in
                viewModel.showComments()
            }

            imageButton(iconName: "paperplane") {
                print($0 + " tapped!")
            }

            Spacer()

            imageButton(
                iconName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark"
            ) { _ in
                viewModel.toggleBookmark()
            }
        }
    }

    private var footerTextsView: some View {
        VStack(alignment: .leading, spacing: 7) {
            NavigationLink(value: viewModel.post.likes) {
                Text(String(viewModel.post.likesCount) + " To se mi líbí!")
                    .fontWeight(.semibold)
                    .foregroundStyle(.myForeground)
            }

            Text(viewModel.post.author.username)
                .fontWeight(.semibold)
            +
            Text(" " + viewModel.post.text)

            Button {
                viewModel.showComments()
            } label: {
                Text("Zobrazit komentáře (" + String(viewModel.post.comments) + ")")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 2)
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
        PostView(
            viewModel: .init(
                post: .postMock,
                onCommentsTapped: {},
                onPostUpdated: {}
            )
        )
    }
}
