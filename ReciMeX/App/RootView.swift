//
//  ContentView.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

enum Screen: Hashable {
  case listRecipe
  case extendRecipe(recipe: Recipe)
}

struct RootView: View {
  var body: some View {
    NavigationStack {
      RecipeListScreen()
        .navigationDestination(for: Screen.self) { screen in
          switch screen {
          case .listRecipe:
            RecipeListScreen()
          case .extendRecipe(let recipe):
            RecipeExtendedScreen(recipe: recipe)
          }
        }
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
