//
//  RecipeExtendedScreen.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import SwiftUI

struct RecipeExtendedScreen: View {
  
  let recipe: Recipe
  
  @StateObject private var vm: RecipeExtendedViewModel = RecipeExtendedViewModel()
  
  init(recipe: Recipe) {
    self.recipe = recipe
  }
  
  var body: some View {
    ScrollView {
      if vm.ingredients != nil && vm.detailData != nil {
        VStack(alignment: .leading) {
          
          // MARK: Creator view
          
          HStack {
            AsyncImage(url: URL(string: vm.detailData!.creator.profileImageUrl ?? "")) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            } placeholder: {
              Color.gray
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            }
            
            Text("by \(vm.detailData!.creator.username)")
            
            Spacer()
          } //:HStack
          .padding(.top, 20)
          
          // MARK: Image
          
          AsyncImage(url: URL(string: vm.detailData?.imageUrl ?? ""), content: { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipped()
          }, placeholder: {
            Color.gray
              .frame(height: 100)
          })
          
          // MARK: Description
          
          Spacer(minLength: 20)
          
          Text("About")
            .font(.headline)
          Text(vm.detailData?.description ?? "")
            .font(.body)
          
          // MARK: Ingredient
          
          Spacer(minLength: 20)
          
          Text("Ingredient")
            .font(.headline)
          
        } //:VStack
        .padding(.horizontal, 20)
      }
    }
    .onAppear {
      vm.fetchData(recipeId: recipe.id)
    }
    .navigationTitle(recipe.title)
  }
}

struct RecipeExtendedScreen_Previews: PreviewProvider {
  static var previews: some View {
    RecipeExtendedScreen(recipe: Recipe(id: "", title: "Test", imageUrl: "", cookTime: 5, prepTime: 5, numSaves: 100))
  }
}
