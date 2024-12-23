import SwiftUI
import DesignSystem

@main
struct Rick_MortyApp: App {
  
  init() {
    changeNavigationStyle()
  }
  
  var body: some Scene {
    WindowGroup {
      MainScreen()
    }
  }
}

//MARK: Настройка панели навигации
extension Rick_MortyApp {
  func changeNavigationStyle() {
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithTransparentBackground()
    
    let backColor = UIColor(red: 39.0 / 255, green: 43.0 / 255, blue: 51.0 / 255, alpha: 1)
    navigationBarAppearance.shadowColor = backColor
    navigationBarAppearance.backgroundColor = backColor
    
    navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationBarAppearance.titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font:  UIFont.systemFont(ofSize: 18, weight: .semibold)
    ]
    
    let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
    backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
    navigationBarAppearance.backButtonAppearance = backButtonAppearance
    
    let rectInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    let backButtonImage = UIImage(named: "backArrow")?.withAlignmentRectInsets(rectInsets)
    navigationBarAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
    
    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
  }
}
