//
//  JSONReader.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/13/24.
//

import Foundation

struct JSONReader {
    
    static func readJSON(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
              } catch {
                  print("Error reading JSON", error)
                  return nil
              }
        }
        
        return nil
    }
}
