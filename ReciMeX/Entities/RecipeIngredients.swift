//
//  RecipeIngredients.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct RecipeIngredients: Codable, Identifiable {
  let id: Int?
  let product: String?
  let quantity: Double?
  let unit: String?
  let productModifier: String?
  let preparationNotes: String?
  let imageFileName: String?
  let rawText: String?
  let rawProduct: String?
  let preProcessedText: String?
}

fileprivate struct HeadingIngredient: Codable {
  let heading: String?
}

enum RecipeIngredientsType {
  case heading(String)
  case ingredient(RecipeIngredients)
}

extension RecipeIngredientsType: Identifiable {
  var id: String {
    switch self {
    case .heading(let heading): return heading
    case .ingredient(let ingredient): return "\(ingredient.id ?? UUID().hashValue)"
    }
  }
}

extension RecipeIngredientsType: Codable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let posibleHeadingData = try container.decode(HeadingIngredient.self)
    if let heading = posibleHeadingData.heading {
      self = .heading(heading)
    } else {
      self = .ingredient(try container.decode(RecipeIngredients.self))
    }
  }
}
