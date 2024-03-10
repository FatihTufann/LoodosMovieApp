protocol MovieSearchViewServiceDelegate {
    func searchMovies(with searchTerm: String, completion: @escaping(Result<[MovieItemModel], NetworkError>) -> Void)
}

class MovieSearchViewService: MovieSearchViewServiceDelegate {
    
    func searchMovies(with searchTerm: String, completion: @escaping (Result<[MovieItemModel], NetworkError>) -> Void) {
        MovieManager.searchMovies(with: searchTerm) { result in
            switch result {
            case .success(let movieItems):
                if movieItems.Response == "True" {
                    completion(.success(movieItems.Search!))
                }else {
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

