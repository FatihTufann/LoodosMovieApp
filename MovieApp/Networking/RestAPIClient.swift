import Alamofire

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
    case APIError(String)
}

class RestAPIClient {
    
    static func request<T: Codable>(route: APIRouter,
                                    completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        AF.request(route).responseDecodable(of: T.self){ response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
            
        }
        
    }
    
}

