import Foundation

// MARK: - CharacterShame
// Список персонажей с информацией о кол-ве страниц
struct CharacterShame: Decodable {
  let info: Info
  let results: [Character]
}

// MARK: - Info
struct Info: Codable {
  let count, pages: Int
  let next, prev: String?
}

