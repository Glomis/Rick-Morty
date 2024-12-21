import SwiftUI

struct CharCell: View {
   var char: Character
  
    var body: some View {
//      if let char {
      VStack(alignment: .leading) {
        ZStack {
          if let data = char.imageData {
            Image(uiImage: UIImage(data: data)!)
              .resizable()
              .scaledToFill()
          } else {
            ProgressView()
          }
        }
        .frame(width: 100, height: 100)
          Text(char.name)
            .font(.title)
          
          HStack {
            Text(char.status.rawValue)
          }
        }
        .padding()
        .task {
          await self.getImage()
        }
//      } else {
//        Text("No char")
//      }
    }
  
  func getImage() async {
//    guard char?.imageData == nil else { return }
    guard let url = URL(string: char.image) else { return}
    char.imageData = try? await URLSession.shared.data(from: url).0
  }
}

#Preview {
  CharCell(char: Character(id: 0, name: "Rick", species: "", type: "", status: .alive, gender: .female, origin: Location(name: "", url: ""), location:  Location(name: "", url: ""), image: "", episode: [], url: "", created: ""))
}
