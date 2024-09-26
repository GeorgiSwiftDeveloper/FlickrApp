//
//  SearchBar.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import SwiftUI

protocol SearchBarCoordinator {
    func makeCoordinator() -> Coordinator
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar: UISearchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

extension SearchBar: SearchBarCoordinator {
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
}

class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
}
