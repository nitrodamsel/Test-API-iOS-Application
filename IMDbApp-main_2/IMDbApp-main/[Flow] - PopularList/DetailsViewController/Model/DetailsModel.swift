import UIKit

struct DetailsModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    var status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name: String?
    let firstAirDate: String?
    let episodeRuntime: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection
        case budget, genres, homepage, id
        case imdbID
        case originalLanguage
        case originalTitle
        case overview, popularity
        case posterPath
        case productionCompanies
        case productionCountries
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages
        case status, tagline, title, video
        case voteAverage
        case voteCount
        case name
        case firstAirDate = "first_air_date"
        case episodeRuntime = "episode_run_time"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath
        case name
        case originCountry
    }
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName
        case iso639_1
        case name
    }
}
