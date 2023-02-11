//
//  Photo.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
