//
//  RecipeExtendedScreen.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

struct RecipeExtendedScreen: View {
  
  let recipe: Recipe
  
  @StateObject private var vm: RecipeExtendedViewModel = RecipeExtendedViewModel()
  
  init(recipe: Recipe) {
    self.recipe = recipe
  }
  
  var body: some View {
    Group {
      if vm.ingredients != nil && vm.detailData != nil {
        HStack {
          
        }
      }
    }
      .onAppear {
        vm.fetchData(recipeId: recipe.id)
      }
      .navigationTitle(recipe.title)
  }
}

struct RecipeExtendedScreen_Previews: PreviewProvider {
  static var previews: some View {
    RecipeExtendedScreen(recipe: Recipe(id: "", title: "Test", imageUrl: "", cookTime: 5, prepTime: 5, numSaves: 100))
  }
}
