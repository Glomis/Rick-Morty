import SwiftUI
import DesignSystem

struct Components {
  
  //MARK: Повторяющееся поле для описания свойст персонажа
  // Используется в каточке персонажа и на жкране подробной инфо
  struct CharactesInfoView: View {
    let character: Character
    let planetColorShame: CharacterPlanetInfo.ColorScheme
    
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text(character.species)
          .font(.DesignFonts.semibold())
        
        HStack(spacing: 5) {
          Circle()
            .fill(character.status == .alive ? Color.aliveColor : .deadColor)
            .frame(width: 5, height: 5)
          
          Text(character.status.rawValue)
            .font(.DesignFonts.semibold())
        }
        
        CharacterPlanetInfo(type: .lastKnown,
                            detailText: character.location.name,
                            colorScheme: planetColorShame)
        
        CharacterPlanetInfo(type: .firstSeen,
                            detailText: character.origin.name,
                            colorScheme: planetColorShame)
        
      }
      .foregroundStyle(.white)
    }
  }
  
  
  //MARK: Поле описания локациий пользователя
  // Стопка с описанием локации, используется с различными темами оформления в разных местах
  struct CharacterPlanetInfo: View {
    let type: InfoType
    let detailText: String
    let colorScheme: ColorScheme
    
    enum InfoType: String {
      case firstSeen = "First seen in:"
      case lastKnown = "Last known location"
    }
    
    enum ColorScheme {
      case white, whiteGreen, grayWhite
      
      // Цвет типа локации
      var locationYypeColor: Color {
        switch self {
        case .white:
            .white
        case .whiteGreen:
            .white
        case .grayWhite:
            .gray
        }
      }
      
      // Цвет названия локации
      var titlelColor: Color {
        switch self {
        case .white:
            .white
        case .whiteGreen:
            .aliveColor
        case .grayWhite:
            .white
        }
      }
    }
    
    var body: some View {
      VStack(alignment: .leading, spacing: 3) {
        Text(type.rawValue)
          .font(.DesignFonts.anotation())
          .foregroundStyle(colorScheme.locationYypeColor)
        Text(detailText)
          .font(.DesignFonts.semibold())
          .foregroundStyle(colorScheme.titlelColor)
      }
    }
  }
}


