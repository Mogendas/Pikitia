//
//  Photo.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import Foundation

struct Photo: Codable, Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
      lhs.id == rhs.id
    }
    
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    var imageURLString: String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
