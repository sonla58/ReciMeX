//
//  RecipeDetail.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct RecipeDetail: Codable {
  let id: String
  let title: String
  let description: String?
  let imageUrl: String
  let creator: Creator
  let cookTime: Int?
  let prepTime: Int?
  let servingSize: Int
  let method: String
  let tags: [String]
}

struct Creator: Codable {
  let username: String
  let profileImageUrl: String?
}

extension RecipeDetail: Identifiable {}
