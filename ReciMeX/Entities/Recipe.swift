//
//  Recipe.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct Recipe: Codable {
  let id: String
  let title: String
  let imageUrl: String
  let cookTime: Int?
  let prepTime: Int
  let numSaves: Int
}

extension Recipe: Identifiable, Hashable {}
