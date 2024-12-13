//
//  CacheImage.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/13/24.
//

import SwiftUI
import UIKit

struct CacheImage: View {
    let url: URL
    
    var body: some View {
        VStack {
            if let data = CacheManager.shared.itemForKey(key: url.absoluteString), let image = UIImage(data: data) {
                Image(uiImage: image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            } else {
                AsyncImage(url: url, content: { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                }, placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                })
            }
        }
        .task {
           await CacheManager.shared.cacheImageForURL(url: url)
        }
    }
}
