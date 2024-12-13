//
//  FetchInterviewAppTests.swift
//  FetchInterviewAppTests
//
//  Created by Alexandre12 on 12/12/24.
//

import Testing
import Foundation

@testable import FetchInterviewApp

// Mock recipe Service
struct RecipeMockService: RecipeServicable {
    enum ResponseType {
        case valid
        case empty
        case malformed
    }
    
    let type: ResponseType
    
    func getRecipes() async throws -> [Recipe] {
        var data: Data?
        var recipes = [Recipe]()
        
        switch type {
        case .valid:
            data = JSONReader.readJSON(fileName: "ValidRecipe")
        case .empty:
            data = JSONReader.readJSON(fileName: "EmptyRecipe")
        case .malformed:
            data = JSONReader.readJSON(fileName: "MalformedRecipe")
        }
        
        if let data {
            do {
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                recipes = recipeResponse.recipes
            } catch {
                throw ServiceErrors.decoding
            }
            
            if recipes.isEmpty {
                throw ServiceErrors.emptyData
            }
        }
        
        return recipes
    }
}

struct FetchInterviewAppTests {
    
    @Test func testValidData() async throws {
        let viewModel = RecipeViewModel(recipeServices: RecipeMockService(type: .valid))
        await viewModel.getRecipes()
        #expect(!viewModel.recipes.isEmpty)
        #expect(viewModel.recipes.count == 2)
    }

    @Test func testEmptyData() async throws {
        let viewModel = RecipeViewModel(recipeServices: RecipeMockService(type: .empty))
        await viewModel.getRecipes()
        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.errorToShow != nil)
        #expect(viewModel.errorToShow == ServiceErrors.emptyData.localizedDescription)
    }
    
    @Test func testMalformedData() async throws {
        let viewModel = RecipeViewModel(recipeServices: RecipeMockService(type: .malformed))
        await viewModel.getRecipes()
        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.errorToShow != nil)
        #expect(viewModel.errorToShow == ServiceErrors.decoding.localizedDescription)
    }
}
