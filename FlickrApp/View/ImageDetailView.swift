//
//  ImageDetailView.swift
//  Flickr
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import Foundation
import SwiftUI

struct ImageDetailView: View {
    @State private var isShareSheetShowing: Bool = false
    @State private var attributedDescription: AttributedString = AttributedString("")
    
    let flickrImage: FlickrImage
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: flickrImage.media?.m ?? ""))
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel("Image: \(flickrImage.title ?? "No Image")")
                
                Text(flickrImage.title ?? "No Title")
                    .bold()
                    .font(.headline)
                
                Text(attributedDescription)
                    .font(.body)
                    .onAppear {
                        attributedDescription = AttributedString(flickrImage.description ?? "No Description Available")
                    }
                
                Text("Author: \(flickrImage.author ?? "Unknown")")
                    .font(.subheadline)
                
                Text("Published: \(flickrImage.published ?? "Unknown")")
                    .font(.footnote)
                
                let dimensions = getImageDimensions(from: flickrImage.description)
                Text("Width: \(dimensions.width) pixels, Height: \(dimensions.height) pixels")
                    .font(.footnote)
                
                Button(action: { isShareSheetShowing = true }) {
                    Text("Share")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .accessibilityHint("Opens a share view to share image and information about the image")
                .padding()
                .sheet(isPresented: $isShareSheetShowing) {
                    if let shareURL = URL(string: flickrImage.media?.m ?? "") {
                        ShareSheetView(items: [shareURL, flickrImage.title ?? "No title"])
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(flickrImage.title ?? "No Title"), displayMode: .inline)
        .accessibilityElement(children: .combine)
    }
    
    private func getImageDimensions(from description: String?) -> (width: Int, height: Int) {
        return (width: 0, height: 0)
    }
}

struct ShareSheetView: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
