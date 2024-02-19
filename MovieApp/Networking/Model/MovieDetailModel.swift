import Foundation

struct MovieDetailModel: Codable {
    var title: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var actors: String
    var plot: String
    var country: String
    var awards: String
    var poster: String
    var imdbRating: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating
    }
}
