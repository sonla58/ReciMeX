//
//  RecipeListViewModel.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

@MainActor
class RecipeListViewModel: ObservableObject {
  @Injectable private var service: RecipeRepository
  
  @Published var recipes: [Recipe] = []
  
  func fetchData() {
    Task {
      do {
        recipes = try await service.fetchRecipes(byUserId: "7NWpTwiUWQMm89GS3zJW7Is3Pej1")
      } catch {
        // TODO: - Handle error
        print(error)
      }
    }
  }
}
