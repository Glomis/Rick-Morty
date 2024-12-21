import Foundation
import Observation

// MARK: - Character
@Observable class Character: Decodable, Identifiable {
  let id: Int
  let name: String
  let status: CharStatus
  let species: String
  let type: String
  let gender: CharGender
  let origin, location: Location
  let image: String
  let episode: [String]
  let url: String
  let created: String
  
  var imageData: Data? = nil
  
  init(id: Int, name: String, species: String, type: String, status: CharStatus, gender: CharGender, origin: Location, location: Location, image: String, episode: [String], url: String, created: String, imageData: Data? = nil) {
    self.id = id
    self.name = name
    self.species = species
    self.type = type
    self.status = status
    self.gender = gender
    self.origin = origin
    self.location = location
    self.image = image
    self.episode = episode
    self.url = url
    self.created = created
    self.imageData = imageData
  }
}

// MARK: - Location
struct Location: Codable {
  let name: String
  let url: String?
}

// MARK: - CharStatus
enum CharStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown
}

// MARK: - CharGender
enum CharGender: String, Codable {
  case male = "Male"
  case female = "Female"
  case genderless = "Genderless"
  case unknown
}
