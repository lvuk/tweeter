import SwiftUI

struct UserProfileView: View {
    var user: User
    @State private var selectedFilter: TweetFilterOptions = .tweets
    @StateObject private var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                VStack {
                    ProfileHeaderView(viewModel: viewModel, isFollowed: $viewModel.isFollowed)
                        .padding(.top, 40)
                    
                    FilterButtonView(selectedOption: $selectedFilter)
                        .padding(.top)
                    
                    ForEach(viewModel.userTweets) { tweet in
                        NavigationLink(destination: TweetDetailView(tweet: tweet)) {
                            TweetCell(tweet: tweet)
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle(user.username)
        .onAppear {
            viewModel.fetchUserInfo()
            viewModel.fetchUserTweets()
            viewModel.fetchSavedTweets()
            viewModel.fetchUserStats()
        }
    }
}
