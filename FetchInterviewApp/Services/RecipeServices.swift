//
//  RecipeServices.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/12/24.
//

import Foundation

protocol RecipeServicable {
    func getRecipes() async throws -> [Recipe]
}

struct RecipeServices: RecipeServicable {
    func getRecipes() async throws -> [Recipe] {
        guard let url = URL(string: Constants.recipeURL) else {
            throw ServiceErrors.invalidURL
        }
        
        // Create URLSession
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //Decode JSON to Recipe Model
        do {
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            if recipeResponse.recipes.isEmpty {
                throw ServiceErrors.emptyData
            }
            
            return recipeResponse.recipes
        } catch {
            throw ServiceErrors.decoding
        }
    }
}

