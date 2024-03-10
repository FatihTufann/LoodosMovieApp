class MovieManager {
    
    static func searchMovies(with searchTerm: String, completion: @escaping(Result<MovieSearchResult, NetworkError>) -> Void) {
        return RestAPIClient.request(route: MovieRouter.searchMovies(searchTerm: searchTerm), completion: completion)
    }
    
    static func getMovies(with imdbID: String, completion: @escaping(Result<MovieDetailModel, NetworkError>) -> Void) {
        return RestAPIClient.request(route: MovieRouter.getMovies(imdbID: imdbID), completion: completion)
    }
    
}
