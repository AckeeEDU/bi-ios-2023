//
//  CommentsView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

// TODO: Lecture 09 - finish implementation
/// CommentsView uses iOS17+ changes observation system
struct CommentsView: View {
    // MARK: - Private Properties
    @Bindable var viewModel: CommentsViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                contentView
                    .frame(maxHeight: .infinity)
                
                TextFieldView(
                    text: $viewModel.text,
                    onAddComment: {
                        viewModel.addComment()
                    }
                )
                .background(.quaternary)
            }
            //                .alert(
            //                    "Chceš to opravdu smazat?",
            //                    isPresented: $viewModel.isAlertPresented,
            //                    actions: {
            //                        Button(role: .cancel) {
            //                            commentToBeDeleted = nil
            //                        } label: {
            //                            Text("Zavřít")
            //                        }
            //
            //                        Button(role: .destructive) {
            //                            // Removes all the elements that satisfy the given predicate
            //                            comments.removeAll(where: {
            //                                $0 == commentToBeDeleted
            //                            })
            //                        } label: {
            //                            Text("Smazat")
            //                        }
            //                    }
            //                ) {
            //                    Text("Dojde k nenávratnému smazání komentáře")
            //                }
                .navigationTitle("Comments")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewModel.closeCommentsView()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .task {
                    await viewModel.fetchComments()
                }
        }
    }
    
    // MARK: - UI Components
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else if viewModel.isEmptyTextVisible {
            Text("Přidej první komentář 🤓")
        } else {
            commentsList
        }
    }
    
    var commentsList: some View {
        // A view that provides programmatic scrolling, by working with a proxy to scroll to known child views
        ScrollViewReader { proxy in
            List(viewModel.comments) { comment in
                commentListRow(comment: comment)
                    // Each row must be identifiable
                    .id(comment.id)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .onChange(of: viewModel.comments) { _, newValue in
                // Animate the scroll action 😎
                withAnimation {
                    // Scroll to the row with ID that is equal to the ID of the last item
                    proxy.scrollTo(newValue.last?.id, anchor: .bottom)
                }
            }
        }
    }
    
    func commentListRow(comment: Comment) -> some View {
        HStack(alignment: .top, spacing: 24) {
            let gradient = LinearGradient(
                gradient: Gradient(
                    colors: [
                        .pink,
                        colorScheme == .dark ? .blue : .yellow
                    ]
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Circle()
                .foregroundStyle(gradient)
                .frame(
                    width: 30,
                    height: 30
                )
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(comment.author.username)
                        .fontWeight(.semibold)
                    
                    if comment.author == .userMockMe {
                        Button {
                            viewModel.removeComment(comment: comment)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.pink)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Text(comment.text)
            }
        }
    }
}

extension CommentsView {
    struct TextFieldView: View {
        @Binding var text: String
        var onAddComment: () -> Void
        
        // MARK: - Body
        
        var body: some View {
            Group {
                HStack(spacing: 8) {
                    TextField("Add some text!", text: $text)
                        .autocorrectionDisabled()
                    
                    Button {
                        onAddComment()
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, style: .init(lineWidth: 2))
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CommentsView(
            viewModel: .init(
                postID: "1",
                onCommentsClose: { _ in }
            )
        )
    }
}
