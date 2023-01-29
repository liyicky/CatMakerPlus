//
//  UpslashPhoto.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/24.
//

import Foundation
import SwiftUI

struct UnsplashPhoto: Codable {

    var id: String = UUID().uuidString
    
    let description: String?
    let urls: Urls
    
    struct Urls: Codable {
        let raw: String
        let full: String
    }
    
    var permaDescription: String {
        description ?? "Indescribable"
    }
}

extension UnsplashPhoto: Hashable {
    static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension UnsplashPhoto {
    func getPhotoData() async -> Data {
        guard let url = URL(string: urls.raw) else {
            fatalError("Missing Unsplash URL!")
        }
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                fatalError("Could not connect to Unsplash!")
            }
            
            return data
        } catch {
            fatalError("Something went wrong when trying to get photo data!")
        }
    }
}
