//
//  FetchInterviewAppApp.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/12/24.
//

import SwiftUI

@main
struct FetchInterviewApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeView(viewModel: RecipeViewModel(recipeServices: RecipeServices()))
        }
    }
}
