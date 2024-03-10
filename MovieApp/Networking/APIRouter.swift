import Alamofire
import Foundation


protocol APIRouter: URLRequestConvertible {
    var urlPath: String { get }
    var method: HTTPMethod { get }
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        
        let url = try urlPath.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
