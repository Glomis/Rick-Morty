import SwiftUI
struct Components {
  struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
      Button(action: action) {
        Text(title)
          .font(.title2)
          .padding(.vertical, 8.5)
          .frame(maxWidth: .infinity)
          .background {
            Color.aliveColor
          }
          .clipShape(.rect(cornerRadius: 10))
      }
    }
  }
  
  struct CharactesInfoView: View {
    let character: Character
    let planetColorShame: CharacterPlanetInfo.ColorScheme
    
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 5) {
          Circle()
            .fill(character.status == .alive ? Color.aliveColor : .deadColor)
            .frame(width: 5, height: 5)
          
          Text(character.status.rawValue)
            .foregroundStyle(.white)
        }
        
        CharacterPlanetInfo(type: .lastKnown,
                            detailText: character.location.name,
                            colorScheme: planetColorShame)
        
        CharacterPlanetInfo(type: .firstSeen,
                            detailText: character.origin.name,
                            colorScheme: planetColorShame)
        
      }
    }
  }
  
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
      
      var titleColor: Color {
        switch self {
        case .white:
            .white
        case .whiteGreen:
            .white
        case .grayWhite:
            .gray
        }
      }
      
      var detailColor: Color {
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
          .font(.callout)
          .foregroundStyle(colorScheme.titleColor)
        Text(detailText)
          .font(.headline)
          .foregroundStyle(colorScheme.detailColor)
      }
    }
    
  }
}

struct LocationView: View {
  var body: some View {
    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
  }
}

