//
//  CacheManager.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/13/24.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    
    private var cacheDicationary: [String: Data] = [:]
    
    private init() {}
    
    func cacheItemForKey(key: String, item: Data) {
        cacheDicationary[key] = item
    }
    
    func itemForKey(key: String) -> Data? {
        return cacheDicationary[key]
    }
    
    func cacheImageForURL(url: URL) async {
        if cacheDicationary[url.absoluteString] == nil {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                cacheDicationary[url.absoluteString] = data
            } catch {
                print("Failed to cache Image")
            }
        }
    }
}

