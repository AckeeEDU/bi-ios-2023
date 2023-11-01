//
//  CommentsView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

struct CommentsView: View {
    // MARK: - Public Properties
    @Binding var isCommentsViewPresented: Bool
    
    // MARK: - Private Properties
    @State private var comments = Comment.commentsMock
    @State private var text = ""
    @State private var isAlertPresented = false
    @State private var commentToBeDeleted: Comment?
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            commentsList
                .safeAreaInset(edge: .bottom) {
                    TextFieldView(
                        text: $text,
                        comments: $comments
                    )
                    .background(.quaternary)
                }
                .alert(
                    "Chceš to opravdu smazat?",
                    isPresented: $isAlertPresented,
                    actions: {
                        Button(role: .cancel) {
                            commentToBeDeleted = nil
                        } label: {
                            Text("Zavřít")
                        }
                        
                        Button(role: .destructive) {
                            // Removes all the elements that satisfy the given predicate
                            comments.removeAll(where: {
                                $0 == commentToBeDeleted
                            })
                        } label: {
                            Text("Smazat")
                        }
                    }
                ) {
                    Text("Dojde k nenávratnému smazání komentáře")
                }
                .navigationTitle("Comments")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            isCommentsViewPresented = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.pink)
                    }
                }
            //        .onChange(of: text) { oldValue, newValue in
            //            print(newValue)
            //        }
        }
    }
    
    // MARK: - UI Components
    
    var commentsList: some View {
        List(comments) { comment in
            commentListRow(comment: comment)
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
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
                            commentToBeDeleted = comment
                            isAlertPresented = true
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
        @Binding var comments: [Comment]
        
        // MARK: - Body
        
        var body: some View {
            Group {
                HStack(spacing: 8) {
                    TextField("Add some text!", text: $text)
                        .autocorrectionDisabled()
                    
                    Button {
                        comments.append(
                            Comment(
                                author: .userMockMe,
                                likes: [],
                                text: text
                            )
                        )
                        text = ""
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }
                .tint(.pink)
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
    NavigationStack {
        CommentsView(
            isCommentsViewPresented: .constant(false)
        )
    }
}
