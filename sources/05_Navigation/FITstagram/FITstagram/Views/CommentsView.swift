//
//  CommentsView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

struct CommentsView: View {
    private let comments = Comment.commentsMock
    
    // MARK: - Body
    
    var body: some View {
        List(comments) { comment in
            HStack(alignment: .top, spacing: 24) {
                Circle()
                    .frame(
                        width: 30,
                        height: 30
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(comment.author.username)
                        .fontWeight(.semibold)
                    
                    Text(comment.text)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
}

#Preview {
    CommentsView()
}
