import Foundation
import Observation

@Observable class CharactersViewModel {
  var characters: [Character] = []
  var charactersIsLoaded = false
  var isUnnownError = false
  var status: CharStatus = .alive
  var species = ""
  var name = ""
  var nothingHere = false
  @ObservationIgnored
  var charShameResource: CharacterShameResource.ModelType?
  var page = 1
  
  init() {
    Task{ await addNewCharacters() }
  }
  
  func addNewCharacters() async {
    await updateCharacters(replaceExisting: false)
  }
  
  func fetchNewCharacters() async {
    await updateCharacters(replaceExisting: true)
  }
  
  @MainActor
  private func updateCharacters(replaceExisting: Bool) async {
    if !replaceExisting {
        guard page < charShameResource?.info.pages ?? 2 else {
            return print("No pages anymore")
        }
    } else {
      nothingHere = false
      charShameResource = nil
      page = 1
    }
    
    let params = buildQueryParameters()
    let resource = CharacterShameResource(filters: params)
    do {
        let request = APIRequest(resource: resource)
        let fetchedCharacterShame = try await request.execute()
        
        charShameResource = fetchedCharacterShame
        
        if replaceExisting {
            // Полностью заменяем массив
            characters = fetchedCharacterShame.results
        } else {
            // Добавляем новые данные к массиву
            characters.append(contentsOf: fetchedCharacterShame.results)
        }
        charactersIsLoaded = true
        page += 1
    } catch _ as APIError {
      nothingHere = true
      charShameResource = nil
      page = 1
      characters = []
    } catch {
      characters = []
      charShameResource = nil
      page = 1
      isUnnownError = true
      charactersIsLoaded = true
    }
}
  
  @MainActor
  private func buildQueryParameters() -> [String: String] {
    var parameters: [String: String] = [:]
    
    if !species.isEmpty {
      parameters["species"] = species.lowercased()
    }
    
    if page > 1 {
        parameters["page"] = "\(page)"
    }
    
    parameters["status"] = status.rawValue.lowercased()

    if !name.isEmpty {
        parameters["name"] = name
    }
    
    return parameters
}
}
