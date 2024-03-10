protocol MovieDetailViewServiceDelegate {
    func getMovies(with imdbID: String, completion: @escaping(Result<MovieDetailModel, NetworkError>) -> Void)
}

class MovieDetailViewService: MovieDetailViewServiceDelegate {
    
    func getMovies(with imdbID: String, completion: @escaping (Result<MovieDetailModel, NetworkError>) -> Void) {
        MovieManager.getMovies(with: imdbID, completion: completion)
    }
    
}
