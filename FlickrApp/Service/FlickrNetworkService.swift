//
//  FlickrNetworkService.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import Foundation

class ImageNetworkService {
    func fetchImages(searchText: String, completion: @escaping (Result<[FlickrImage], Error>) -> ()) {
        let baseUrl = "https://api.flickr.com/services/feeds/photos_public.gne"
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "tags", value: searchText)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let feed = try JSONDecoder().decode(FlickrImageFeed.self, from: data)
                if let items = feed.items {
                    completion(.success(items))
                } else {
                    completion(.failure(NSError(domain: "No items found", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
