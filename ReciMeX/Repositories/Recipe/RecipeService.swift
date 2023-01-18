//
//  RecipeService.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct RecipeService: RecipeRepository {
  func fetchRecipes(byUserId id: String) async throws -> [Recipe] {
    try await withCheckedThrowingContinuation({ continuation in
      ReciMeAPIBuilder(method: .get, path: "profile/\(id)/posts")
        .use(provider: BuildinIOSProvider(), responseAdapter: JSONResponse<[Recipe]>())
        .execute { result in
          switch result {
          case .success(let data):
            continuation.resume(returning: data)
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    })
  }
  
  func getRecipeDetail(byRecipe id: String) async throws -> RecipeDetail {
    try await withCheckedThrowingContinuation({ continuation in
      ReciMeAPIBuilder(method: .get, path: "recipe/\(id)")
        .use(provider: BuildinIOSProvider(), responseAdapter: JSONResponse<RecipeDetail>())
        .execute { result in
          switch result {
          case .success(let data):
            continuation.resume(returning: data)
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    })
  }
  
  func getRecipeIngredients(byRecipe id: String) async throws -> [RecipeIngredientsType] {
    try await withCheckedThrowingContinuation({ continuation in
      ReciMeAPIBuilder(method: .get, path: "recipe/\(id)/ingredients")
        .use(provider: BuildinIOSProvider(), responseAdapter: JSONResponse<[RecipeIngredientsType]>())
        .execute { result in
          switch result {
          case .success(let data):
            continuation.resume(returning: data)
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    })
  }
}
