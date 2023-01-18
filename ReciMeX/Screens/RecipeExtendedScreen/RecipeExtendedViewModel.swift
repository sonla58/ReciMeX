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
  @Published var methods: [String] = []
  @Published var methodHeading: String = ""
  
  func fetchData(recipeId: String) {
    Task {
      do {
        detailData = try await service.getRecipeDetail(byRecipe: recipeId)
        serves = detailData!.servingSize
        
        var methodComponents = detailData!.method.components(separatedBy: .newlines)
        if methodComponents.first?.hasPrefix("##") == true {
          methodHeading = methodComponents.first!.replacingOccurrences(of: "##", with: "")
          methodComponents.removeFirst()
        }
        methods = methodComponents
        
        ingredients = try await service.getRecipeIngredients(byRecipe: recipeId)
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
