//
//  ImageGridView.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import SwiftUI

struct ImageGridView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let images: [FlickrImage]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(images) { image in
                    NavigationLink(value: image) {
                        AsyncImage(url: URL(string: image.media?.m ?? "")) { phase in
                            switch phase {
                            case .empty, .failure:
                                Image(systemName: "photo")
                                    .accessibilityLabel("Failed to load image")
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .cornerRadius(10)
//                                         .accessibilityLabel() TODO: get the image title properly and assign String to accessibilty label
                                @unknown default:
                                    EmptyView()
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationDestination(for: FlickrImage.self) { flickrImage in
            ImageDetailView(flickrImage: flickrImage)
        }
    }
    
    private var columns: [GridItem] {
        switch horizontalSizeClass {
        case .compact:
            return Array(repeating: GridItem(.adaptive(minimum: 100)), count: 2)
        default:
            return Array(repeating: GridItem(.adaptive(minimum: 100)), count: 4)
        }
    }
}
