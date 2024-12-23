import Foundation
import Observation

@Observable class CharactersViewModel {
  var characters: [Character] = []
  var status: String = ""
  var name = ""
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
  
  private func updateCharacters(replaceExisting: Bool) async {
    if !replaceExisting {
        // Проверяем, есть ли ещё страницы
        guard page < charShameResource?.info.pages ?? 2 else {
            return print("No pages anymore")
        }
    } else {
        // Сбрасываем данные для нового запроса
        charShameResource = nil
        page = 1
    }
    
    let params = buildQueryParameters()
    print(params)
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
        
        print("Char count = \(characters.count)")
        page += 1
    } catch {
      characters = []
      charShameResource = nil
      page = 1
        print("DEBUG: ERROR - \(error)")
    }
}
  
  private func buildQueryParameters() -> [String: String] {
    var parameters: [String: String] = [:]
    
    if page > 1 {
        parameters["page"] = "\(page)"
    }
    
    if !status.isEmpty {
      parameters["status"] = status.lowercased()
    }
//    parameters["specie"] = specie.lowercased()

    if !name.isEmpty {
        parameters["name"] = name
    }
    
    return parameters
}
}
