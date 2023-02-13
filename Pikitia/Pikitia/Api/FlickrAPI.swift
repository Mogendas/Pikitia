//
//  FlickrAPI.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import Foundation

enum APIError: Error {
    case runtimeError(String)
}

final class FlickrAPI {
    let baseUrl = "https://www.flickr.com/services/rest/"
        
    func searchFor(searchString: String) async throws -> PhotosData {
        guard var url = URL(string: baseUrl) else { throw APIError.runtimeError("URL error") }
        
        let items = [URLQueryItem(name: "method", value: "flickr.photos.search"),
                     URLQueryItem(name: "api_key", value: "6bfb8fbd1f722c1bc38a670ee835c620"),
                     URLQueryItem(name: "text", value: searchString),
                     URLQueryItem(name: "format", value: "json"),
                     URLQueryItem(name: "nojsoncallback", value: "1")]
        
        url.append(queryItems: items)
        
//        print("URL: \(url.absoluteString)")

        let data = try await sendRequest(url: url)
        
        return try JSONDecoder().decode(PhotosData.self, from: data)
    }
    
    
    private func sendRequest(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
//            print("RawData: \(json)")
//        } catch {
//            print("Error: \(error)")
//        }
        
        return data
    }
}
