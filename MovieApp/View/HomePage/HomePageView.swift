import SwiftUI
import Firebase
import NavigationTransitions

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
                                        NavigationLink(destination: MovieDetail(imdbID: movie.imdbID)
                                            .navigationBarBackButtonHidden(true)) {
                                            MovieItem(movie: movie, width: geometry.size.width)
                                        }
                                        .listRowSeparator(.hidden)
                                        .onTapGesture{
                                            LogEventManager().logActionStatus(title: "navigate_to_detail", status: ActionStatus.navigation_link_pressed)
                                        }
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
            .navigationTransition(
                .fade(.in).animation(.easeInOut(duration: 0.3))
            )
            .onAppear {
                LogEventManager().logCurrentView(screenName: "HomePage", className: "\(HomePageView.self)")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            
        }
    }
    
    
}




#Preview {
    HomePageView()
}
