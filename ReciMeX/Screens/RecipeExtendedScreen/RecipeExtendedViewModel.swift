//
//  RecipeExtendedViewModel.swift
//  ReciMeX
//
//  Created by Anh Son Le on 19/01/2023.
//

import SwiftUI

@MainActor
class RecipeExtendedViewModel: ObservableObject {
  @Injectable private var service: RecipeRepository
  
  @Published var detailData: RecipeDetail?
  @Published var ingredients: RecipeIngredients?
  
  func fetchData(recipeId: String) {
    Task {
      do {
        detailData = try await service.getRecipeDetail(byRecipe: recipeId)
        ingredients = try await service.getRecipeIngredients(byRecipe: recipeId)
      } catch {
        // TODO: - Handle error
        print(error)
      }
    }
  }
}
