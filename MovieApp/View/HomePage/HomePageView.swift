import SwiftUI
import Firebase

struct HomePageView: View {
    
    @StateObject var viewModel = MovieSearchViewModel()
    @State private var searchText: String = ""

    
    
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView {
                VStack(alignment: .leading){
                    
                    HeaderView()
                    
                    ScrollView {
                        SearchBar(searchText: $searchText){
                            viewModel.searchMovies(with: searchText)
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .scaleEffect(1.7)
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .padding(.top, geometry.size.width * 0.5)
                                
                        }else {
                            if viewModel.searchResults.isEmpty {
                                if !viewModel.isFirst{
                                    NoResultsView()
                                        .padding(.top, geometry.size.width * 0.5)
                                }
                            }else {
                                LazyVStack {
                                    ForEach(viewModel.searchResults) { movie in
                                        NavigationLink(destination: MovieDetail(imdbID: movie.imdbID).navigationBarBackButtonHidden(true)) {
                                            MovieItem(movie: movie, width: geometry.size.width)
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                                .padding(.horizontal,15)
                            }
                        }
                 
                        
                    }
                    .listStyle(PlainListStyle())
                }
                .background(Color(.black))
            } 
            .onAppear {
                Analytics.logEvent(AnalyticsEventScreenView,
                                   parameters: [AnalyticsParameterScreenName: "\(HomePageView.self)",
                                               AnalyticsParameterScreenClass: "\(HomePageView.self)"])
            }
            
            
        }
    }
    
    
}




#Preview {
    HomePageView()
}
