//
//  ContentView.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: FlickrImageViewModel = FlickrImageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView()
                                .accessibilityLabel("Loading image")
                        }
                    }
                    .padding()
                ImageGridView(images: viewModel.images)
            }
            .navigationBarTitle("Flickr Image Search")
        }
        .onChange(of: viewModel.searchText) {
            viewModel.fetchImages()
        }
    }
}

#Preview {
    ContentView()
}
