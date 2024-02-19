import Foundation
import Alamofire
import Firebase

class MovieSearchViewModel: ObservableObject {
    
    @Published var searchResults: [MovieItemModel] = []
    @Published var isFirst: Bool = true
    @Published var isLoading: Bool = false
    
    func searchMovies(with searchTerm: String) {
        isLoading = true
        let urlString = Endpoint.baseUrl.rawValue + "/?s=\(searchTerm)&apikey=\(Config.apiKey)"
        
        AF.request(urlString).responseDecodable(of: MovieSearchResult.self) { response in
            
            switch response.result {
            case .success(let searchData):
                Analytics.logEvent("network_event", parameters: [
                    "ViewModel": "MovieSearchViewModel",
                    "message": "Success"
                ])
                if searchData.Response == "True" {
                    self.searchResults = searchData.Search!
                }else {
                    self.searchResults = []
                }
                self.isFirst = false
            case .failure(let error):
                Analytics.logEvent("network_event", parameters: [
                    "ViewModel": "MovieSearchViewModel",
                    "message": "\(error.localizedDescription)"
                ])
                self.isFirst = false
                self.searchResults = []
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
        }
    }
    
}
