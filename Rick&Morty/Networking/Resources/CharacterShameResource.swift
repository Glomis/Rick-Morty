import Foundation

// Ресурс для получения CharacterShame (Список персонажей и инфо о кол-ве страниц)
struct CharacterShameResource: APIResource {
  typealias ModelType = CharacterShame
  var methodPath = "/character"
  var httpMethod: HttpMethod = .get
  var filters: [String : String]?
}
