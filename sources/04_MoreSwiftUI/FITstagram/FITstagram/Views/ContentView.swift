//
//  ContentView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    let post: Post = .postMock

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            headerView
                .padding(.horizontal)

            Image(post.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)

            VStack(alignment: .leading, spacing: 16) {
                buttonsHorizontalView
                    .frame(height: 24)

                footerView
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            .padding(.top, 2)
            .padding(.horizontal)
        }
        .tint(.pink) // Tint color is applied to all nested precedents
    }

    // MARK: - Main components

    var headerView: some View {
        HStack {
            Text(post.author.username)
                .font(.subheadline)
                .fontWeight(.semibold)

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

    var buttonsHorizontalView: some View {
        HStack(spacing: 16) {
            imageButton(iconName: "heart") {
                print($0 + " tapped!")
            }

            imageButton(iconName: "message") {
                print($0 + " tapped!")
            }

            imageButton(iconName: "paperplane") {
                print($0 + " tapped!")
            }

            Spacer()

            imageButton(iconName: "bookmark") { name in
                print(name + " tapped!")
            }
        }
    }

    var footerView: some View {
        VStack(alignment: .leading, spacing: 7) {
            Button {
                print("likes tapped!")
            } label: {
                Text(String(post.numberOfLikes) + " To se mi líbí!")
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }

            Text(post.author.username)
                .fontWeight(.semibold)
            +
            Text(" " + "Toto je muj velmi dlouhy komentar a bude na dva radky")

            Button {
                print("comments tapped!")
            } label: {
                Text("Zobrazit komentáře (" + String(post.numberOfComments) + ")")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            }
        }
    }

    // MARK: - Helpers

    /// Returns button with a wrapped image for given system icon name
    /// - Parameters:
    ///   - name: Given system icon name
    ///   - action: Action which should be performed on tap
    ///
    /// - Note: `@escaping` - Tells the Swift compiler that we know
    /// the closure leaves the scope it was passed to, and that we're okay with that
    func imageButton(
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
    ContentView()
}
