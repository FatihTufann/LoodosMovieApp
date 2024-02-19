import Foundation

struct MovieSearchResult: Codable {
    let Search: [MovieItemModel]?
    let totalResults: String?
    let Response: String
}

struct MovieItemModel: Codable, Identifiable {
    let id = UUID()
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
