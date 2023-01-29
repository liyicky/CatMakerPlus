//
//  UpsplashAPIManager.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/24.
//

import Foundation

final class UnsplashAPIManager {
    static let instance = UnsplashAPIManager()
    
    let apiUrl = "https://api.unsplash.com/photos/random/?query=cat&client_id=rFzPUWOMoTVMKobubH36URmStcc1p9KsW-Y3GO-zNjU"
    
    func fetchRandomPhoto(withCompletion completion: @escaping (UnsplashPhoto?) -> Void) {
        guard let url = URL(string: apiUrl) else {
            print("Couldn't make the url work")
            DispatchQueue.main.async { completion(nil) }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Couldn't get the data")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Response Status Failed: \(response.statusCode)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            if let error = error {
                print("Unspash API error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let photo = try? JSONDecoder().decode(UnsplashPhoto.self, from: data)
            DispatchQueue.main.async {
                print("Data fetched successfully")
                completion(photo)
            }
        }
        task.resume()
    }
}
