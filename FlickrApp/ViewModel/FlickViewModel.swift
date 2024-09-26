//
//  FlickViewModel.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import Foundation
import SwiftUI

class FlickrImageViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private var flickrService: ImageNetworkService = ImageNetworkService()

    func fetchImages() {
        guard !searchText.isEmpty else {
            images = []
            isLoading = false
            return
        }
        
        isLoading = true
        flickrService.fetchImages(searchText: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.images = images
                case .failure(let error):
                    print(error)
                    self?.images = []
                }
                self?.isLoading = false
            }
        }
    }
}
