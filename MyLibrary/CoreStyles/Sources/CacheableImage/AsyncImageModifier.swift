//
//  AsyncImageModifier.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SwiftUI

struct AsyncImageModifier: ViewModifier {
    @State private var uiImage: UIImage?

    let url: URL
    let placeholder: Image

    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    } else {
                        placeholder
                            .onAppear {
                                loadImage()
                            }
                    }
                }
            )
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.image(for: url) {
            uiImage = cachedImage
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.setImage(image, for: url)
                    DispatchQueue.main.async {
                        uiImage = image
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    uiImage = UIImage(systemName: "photo")
                }
            }
        }
    }
}

public extension View {
    func asyncImage(url: URL, placeholder: Image = Image(systemName: "photo")) -> some View {
        self.modifier(AsyncImageModifier(url: url, placeholder: placeholder))
    }
}
