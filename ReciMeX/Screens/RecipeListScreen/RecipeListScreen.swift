//
//  RecipeListScreen.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

struct RecipeListScreen: View {
  var body: some View {
    VStack {
      NavigationLink("Move", value: Screen.extendRecipe(id: ""))
    }
      .navigationTitle("Recipe List")
  }
}

struct RecipeListScreen_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListScreen()
  }
}
