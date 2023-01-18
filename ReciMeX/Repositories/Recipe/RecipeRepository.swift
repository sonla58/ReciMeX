//
//  RecipeRepository.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

protocol RecipeRepository {
  func fetchRecipes(byUserId id: String) async throws -> [Recipe]
  func getRecipeDetail(byRecipe id: String) async throws -> RecipeDetail
  func getRecipeIngredients(byRecipe id: String) async throws -> [RecipeIngredientsType]
}
