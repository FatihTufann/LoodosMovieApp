import Alamofire
import Foundation

enum MovieRouter: APIRouter {
    
    
    case searchMovies(searchTerm: String)
    case getMovies(imdbID: String)
    
    var urlPath: String {
        switch self {
        case .searchMovies(let searchTerm):
            return Endpoint.baseUrl.rawValue + "/?s=\(searchTerm)&apikey=\(Config.apiKey)"
        case .getMovies(let imdbID):
            return Endpoint.baseUrl.rawValue + "/?i=\(imdbID)&apikey=\(Config.apiKey)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchMovies:
            return .get
        case .getMovies:
            return .get
        }
    }
    
        
}

