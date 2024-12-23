import Foundation
import Observation

// MARK: - Character
// Персонаж (основная модель приложения)
@Observable class Character: Decodable, Identifiable, Hashable {
  
  static func == (lhs: Character, rhs: Character) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }
  
  let id: Int
  let name, species, type, image, url, created: String
  let status: CharStatus
  let gender: CharGender
  let origin, location: Location
  let episode: [String]
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
  
  // Персонаж для превью
  static let Moc = Character(id: 1, name: "Rick Sanchez", species: "Human", type: "",
                             status: .alive, gender: .male,
                             origin: Location(name: "Earth (C-137)",
                             url: "https://rickandmortyapi.com/api/location/1"),
                             location: Location(name: "Citadel of Ricks",
                             url: "https://rickandmortyapi.com/api/location/3"),
                             image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                             episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/5","https://rickandmortyapi.com/api/episode/6","https://rickandmortyapi.com/api/episode/11","https://rickandmortyapi.com/api/episode/12"],
                             url: "https://rickandmortyapi.com/api/character/1",
                             created: "2017-11-04T18:48:46.250Z"
  )
  
  // Метод загрузки изображения персонажа
  func getImage() async {
    guard imageData == nil else { return }
    guard let url = URL(string: image) else { return }
    let resource = ImageRequest(url: url)
    imageData = try? await resource.execute()
  }
}

// MARK: - Location
// От куда персонаж или где был последний раз
struct Location: Codable {
  let name: String
  let url: String?
}

// MARK: - CharStatus
// Текущий статус персонажа
enum CharStatus: String, Codable, CaseIterable{
  case alive = "Alive"
  case dead = "Dead"
  case unknown
  static let allCases: [CharStatus] = [.alive, .dead]
}

// MARK: - CharGender
// Пол персонажа
enum CharGender: String, Codable, CaseIterable {
  case male = "Male"
  case female = "Female"
  case genderless = "Genderless"
  case unknown
  
  static var allCases: [CharGender] = [.female, .male, .unknown]
}
