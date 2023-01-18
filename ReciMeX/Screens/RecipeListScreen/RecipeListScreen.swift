//
//  RecipeListScreen.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

struct RecipeListScreen: View {
  
  @StateObject private var vm: RecipeListViewModel = RecipeListViewModel()
  
  private let columns = [
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center),
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 20) {
        ForEach(vm.recipes) { recipe in
          NavigationLink(value: Screen.extendRecipe(recipe: recipe)) {
            RecipeTile(recipe: recipe)
          }
          .buttonStyle(PlainButtonStyle())
        }
      }
      .padding(.horizontal, 20)
      .padding(.top, 16)
    }
    .onAppear {
      vm.fetchData()
    }
    .navigationTitle("Recipe List")
  }
}

struct RecipeListScreen_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListScreen()
  }
}
