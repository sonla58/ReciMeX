//
//  RecipeTile.swift
//  ReciMeX
//
//  Created by Anh Son Le on 19/01/2023.
//

import SwiftUI

struct RecipeTile: View {
  let recipe: Recipe
  
  init(recipe: Recipe) {
    self.recipe = recipe
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .bottom) {
        Color.clear
        
        HStack {
          Text("\(recipe.prepTime + (recipe.cookTime ?? 0))m")
            .font(Font.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(.white)
          Spacer()
          Text("\(recipe.numSaves)")
            .font(Font.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(.white)
        }
        .padding(20)
        .background {
          LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
        }
      }
      .background(content: {
        AsyncImage(url: URL(string: recipe.imageUrl)) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .aspectRatio(1, contentMode: .fill)
          case .failure(_), .empty:
            AsyncImage(url: URL(string: "https://via.placeholder.com/300"))
          @unknown default:
            EmptyView()
          }
        }
      })
      .cornerRadius(12)
      .aspectRatio(3/4, contentMode: .fit)
      .clipped()
      
      Text(recipe.title)
        .font(Font.headline)
        .lineLimit(1)
    }
  }
}
