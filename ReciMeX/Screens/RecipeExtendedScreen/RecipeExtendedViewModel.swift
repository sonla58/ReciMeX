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
  @Published var ingredients: [RecipeIngredientsType] = []
  @Published var serves: Int = 0
  
  func fetchData(recipeId: String) {
    Task {
      do {
        detailData = try await service.getRecipeDetail(byRecipe: recipeId)
        ingredients = try await service.getRecipeIngredients(byRecipe: recipeId)
        serves = detailData!.servingSize
      } catch {
        // TODO: - Handle error
        print(error)
      }
    }
  }
  
  func minusServes() {
    if serves < 1 {
      return
    }
    serves = serves - 1
  }
  
  func plusServes() {
    if serves > 19 {
      return
    }
    serves = serves + 1
  }
}
