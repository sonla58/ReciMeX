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
  
  private func getQuantityOfGredient(originalQuantity: Double) -> Double {
    guard let data = vm.detailData else { return 0.0 }
    let factor = Double(vm.serves) / Double(data.servingSize)
    return originalQuantity * factor
  }
  
  var creatorView: some View {
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
  }
  
  var descriptionView: some View {
    Group {
      Spacer(minLength: 20)
      
      Text("About")
        .font(.title2)
      Text(vm.detailData?.description ?? "")
        .font(.body)
    }
  }
  
  var ingredientSectionView: some View {
    Group {
      Spacer(minLength: 20)
      
      Text("Ingredient")
        .font(.title2)
      
      Spacer(minLength: 16)
      
      HStack {
        Button {
          vm.minusServes()
        } label: {
          Image(systemName: "minus.circle")
        }
        
        Text("\(vm.serves) serves")
        
        Button {
          vm.plusServes()
        } label: {
          Image(systemName: "plus.circle")
        }
      }
      
      ForEach(vm.ingredients) { ingredientType in
        switch ingredientType {
        case .heading(let heading):
          Text(heading)
            .font(.headline)
            .padding(.top, 12)
        case .ingredient(let data):
          HStack {
            // Placeholder Imgae
            Color.gray
              .frame(width: 30, height: 30)
              .clipShape(Circle())
            
            VStack(alignment: .leading) {
              if data.rawProduct != nil {
                Text("\(String(format: "%.1f", getQuantityOfGredient(originalQuantity: data.quantity ?? 0.0))) \(data.unit ?? "") \(data.productModifier ?? "") \(data.rawProduct ?? "")")
                Text(data.preparationNotes ?? "")
                  .font(.footnote)
              } else {
                Text(data.rawText ?? "")
              }
            }
          }
        }
      } //:ForEach
    }
  }
  
  var tagSection: some View {
    Group {
      Spacer(minLength: 20)
      
      Text("Tags")
        .font(.title2)
      
      // TODO: Tag view
    }
  }
  
  var body: some View {
    ScrollView(.vertical) {
      if vm.detailData != nil {
        VStack(alignment: .leading) {
          
          // MARK: Creator view
          
          creatorView
          
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
          
          descriptionView
          
          // MARK: Ingredient
          
          ingredientSectionView
          
          // MARK: Method
          
          Spacer(minLength: 20)
          
          Text("Method")
            .font(.title2)
          
          if !vm.methodHeading.isEmpty {
            Text(vm.methodHeading)
              .font(.title3)
              .padding(.top, 12)
          }
          
          ForEach(Array(vm.methods.enumerated()), id: \.offset) { index, element in
            Group {
              Text("Step \(index + 1)")
                .font(.headline)
                .padding(.top, 12)
              Text(element)
                .padding(.top, 8)
            }
          }
          
          tagSection
          
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
