import Foundation
import Observation

@Observable class CharactersViewModel {
  var characters: [Character] = []
  var page = 1
  var data: CharacterShameResource.ModelType?
  
  func getCharacters() async {
    var resource = CharacterShameResource(httpMethod: .get)
    if data != nil {
      resource = CharacterShameResource(filters: ["page" : String(page)], httpMethod: .get)
    }
    do {
      let request = APIRequest(resource: resource)
      data = try await request.execute()
      characters.append(contentsOf: data!.results)
      print("Char count = \(characters.count)")
      page += 1
    } catch {
      print("DEBUG: ERROR - \(error)")
    }
  }
}
