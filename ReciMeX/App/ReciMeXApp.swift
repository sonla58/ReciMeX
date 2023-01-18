//
//  ReciMeXApp.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

@main
struct ReciMeXApp: App {
  
  internal var di: DIInjector = DefaultDIInjector()
  
  init() {
    di.register()
  }
  
  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}
