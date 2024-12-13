//
//  RecipeViewModel.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/12/24.
//

import Foundation

@Observable
final class RecipeViewModel {
    
    var recipes = [Recipe]()
    var errorToShow: String?
    
    private var recipeServices: RecipeServicable
    
    init(recipeServices: RecipeServicable) {
        self.recipeServices = recipeServices
    }
    
    func getRecipes() async {
        do {
            self.recipes = try await recipeServices.getRecipes()
        } catch {
            errorToShow = error.localizedDescription
        }
    }
}

