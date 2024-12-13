//
//  ContentView.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/12/24.
//

import SwiftUI

struct RecipeView: View {
    @State var viewModel: RecipeViewModel
    @State var refreshID = UUID()
    var body: some View {
        NavigationStack {
            List(viewModel.recipes) { recipe in
                HStack {
                    if let url = URL(string: recipe.photoURLSmall ?? "") {
                        CacheImage(url: url)
                    } else {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(recipe.name)
                }
            }
            .id(refreshID)
            .task {
                await viewModel.getRecipes()
            }
            .refreshable {
                refreshID = UUID()
                Task {
                    await viewModel.getRecipes()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
        
        
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipeServices: RecipeServices()))
}
