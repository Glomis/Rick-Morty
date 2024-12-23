import Foundation
import Observation

// MARK: - Character
 @Observable class Character: Decodable, Identifiable, Hashable {
  static func == (lhs: Character, rhs: Character) -> Bool {
    lhs.id == rhs.id
  }
   
   func hash(into hasher: inout Hasher) {
       hasher.combine(id)
       hasher.combine(name)
   }
  
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
  
   static let Moc = Character(id: 1, name: "Rick Sanchez", species: "Human", type: "", status: .alive, gender: .male, origin: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/3","https://rickandmortyapi.com/api/episode/4","https://rickandmortyapi.com/api/episode/5","https://rickandmortyapi.com/api/episode/6","https://rickandmortyapi.com/api/episode/7","https://rickandmortyapi.com/api/episode/8","https://rickandmortyapi.com/api/episode/9","https://rickandmortyapi.com/api/episode/10","https://rickandmortyapi.com/api/episode/11","https://rickandmortyapi.com/api/episode/12"], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
   
  func getImage() async {
     guard imageData == nil else { return }
     guard let url = URL(string: image) else { return }
     let resource = ImageRequest(url: url)
     imageData = try? await resource.execute()
   }
}

// MARK: - Location
struct Location: Codable {
  let name: String
  let url: String?
}

// MARK: - CharStatus
enum CharStatus: String, Codable, CaseIterable{
  case alive = "Alive"
  case dead = "Dead"
  case unknown
  static let allCases: [CharStatus] = [.alive, .dead]
}

// MARK: - CharGender
enum CharGender: String, Codable, CaseIterable {
  case male = "Male"
  case female = "Female"
  case genderless = "Genderless"
  case unknown
  
  static var allCases: [CharGender] = [.female, .male, .unknown]
}
