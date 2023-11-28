import SwiftUI

final class PostDetailAPI {
    func fetchPostDetail(postID: Post.ID) async throws -> Post {
        let request = URLRequest(url: .post(id: postID))
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
}

@Observable
final class PostDetailViewModel {
    var post: Post?
    var comments = [Comment]()
    var isFullscreen = false
    
    var isLoading: Bool {
        post == nil
    }
    
    let postID: Post.ID
    
    init(postID: Post.ID) {
        self.postID = postID
    }
    
    func fetchData() async {
        do {
            comments = try await fetchComments()
            post = try await fetchPostDetail()
            
// Bezi paralelne
//            (post, comments) = try await (fetchPostDetail(), fetchComments())
        } catch {
            print("[ERROR]", error)
        }
    }
    
    private func fetchPostDetail() async throws -> Post {
        apiService.fetch()
    }
    
    private func fetchComments() async throws -> [Comment] {
        let request = URLRequest(url: .comments(postID: postID))
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Comment].self, from: data)
    }
}

struct PostDetailView: View {
    @Bindable var viewModel: PostDetailViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme2) var theme
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
                .task {
                    await viewModel.fetchData()
                }
        } else if let post = viewModel.post {
            mainView(post: post)
        } else {
            let _ = assertionFailure("Hele bacha")
        }
    }
    
    private func mainView(post: Post) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                photosView(post: post)
                    .onTapGesture {
                        withAnimation {
                            viewModel.isFullscreen.toggle()
                        }
                    }
                
                if !viewModel.comments.isEmpty, !viewModel.isFullscreen {
                    commentsHeader(post: post)
                        .padding()
                    
                    commentsList(post: post)
                        .padding(.horizontal)
                }
            }
        }
        .scrollDisabled(viewModel.isFullscreen)
        .ignoresSafeArea()
    }
    
    private func commentsHeader(post: Post) -> some View {
        HStack {
            Text("Komentáře")
                .bold()
            
            Spacer()
            
            Button { } label: {
                Label("Přidat", systemImage: "plus")
            }
        }
    }
    
    private func commentsList(post: Post) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.comments) { comment in
                
                Text(comment.author.username + "  ")
                    .foregroundStyle(theme.commentAuthor)
                    .bold() +
                Text(comment.text)
                    .foregroundStyle(theme.commentText)
            }
        }
    }
    
    private func photosView(post: Post) -> some View {
        TabView {
            ForEach(post.photos, id: \.self) { url in
                RemoteImage(url: url)
                    .aspectRatio(contentMode: .fill)
            }
        }
        .aspectRatio(viewModel.isFullscreen ? 0.5 : 1, contentMode: .fit)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(post.author.username)
                    .bold()
                
                Text(post.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(UIColor.label).opacity(0.6))
            .foregroundStyle(Color(UIColor.systemBackground))
//            .opacity(viewModel.isFullscreen ? 0 : 1)
        }
    }
}

#Preview {
    PostDetailView(viewModel: .init(postID: "1"))
}

#Preview("Red") {
    PostDetailView(viewModel: .init(postID: "1"))
        .environment(\.theme, .init(commentAuthor: .red))
}
