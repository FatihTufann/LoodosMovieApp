import Foundation
import Alamofire
import Firebase


class MovieDetailViewModel: ObservableObject {
    
    private let movieDetailViewService: MovieDetailViewServiceDelegate
    
    init(movieDetailViewService: MovieDetailViewServiceDelegate = MovieDetailViewService()) {
        self.movieDetailViewService = movieDetailViewService
    }
    
    @Published var detailResults: MovieDetailModel?
    @Published var response: Bool = true
    
//    func getMovies(with imdbID: String) {
//        let urlString = Endpoint.baseUrl.rawValue + "/?i=\(imdbID)&apikey=\(Config.apiKey)"
//        
//        AF.request(urlString).responseDecodable(of: MovieDetailModel.self) { response in
//            switch response.result {
//            case .success(let detailData):
//                Analytics.logEvent("network_event", parameters: [
//                    "ViewModel": "MovieDetailViewModel",
//                    "message": "Success"
//                ])
//                self.detailResults = detailData
//                self.response = true
//            case .failure(let error):
//                Analytics.logEvent("network_event", parameters: [
//                    "ViewModel": "MovieDetailViewModel",
//                    "message": "\(error.localizedDescription)"
//                ])
//                self.response = false
//                self.detailResults = nil
//            }
//        }
//    }
    
    func getMovies(with imdbID: String) {
        
        movieDetailViewService.getMovies(with: imdbID) { result in
            switch result {
            case .success(let detailData):
                self.detailResults = detailData
                self.response = true
            case .failure(let error):
                self.response = false
                self.detailResults = nil
            }
            
        }
        
    }
    
}

