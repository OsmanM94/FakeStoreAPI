//
//  ImageLoader.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 04/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct ImageLoader: View {

    let url: URL
    var contentMode: ContentMode = .fit
    
    var body: some View {
       Rectangle()
            .opacity(0)
            .overlay {
                SDWebImageLoader(url: url, contentMode: contentMode)
            }
            .clipped()
    }
}

#Preview {
    ImageLoader(url: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!, contentMode: .fit)
        .frame(height: 300)
}

fileprivate struct SDWebImageLoader: View {
    
    let url: URL
    var contentMode: ContentMode = .fit
    
    var body: some View {
        WebImage(url: url) { image in
            image
        } placeholder: {
            ProgressView()
                .scaleEffect(1.5)
        }
        .resizable()
        .aspectRatio(contentMode: contentMode)
        .transition(.fade(duration: 0.5))
    }
}

final class ImagePrefetcher {
    
    static let instance = ImagePrefetcher()
    private let prefetcher = SDWebImagePrefetcher()
    
    private init() {}
    
    func startPrefetching(urls: [URL]) {
        prefetcher.prefetchURLs(urls)
    }
    
    func stopPrefetching() {
        prefetcher.cancelPrefetching()
    }
}



