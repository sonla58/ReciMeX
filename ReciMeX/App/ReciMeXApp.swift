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
  
  var body: some Scene {
    WindowGroup {
      RootView()
        .onAppear {
          di.register()
        }
    }
  }
}
