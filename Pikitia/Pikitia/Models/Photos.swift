//
//  Photos.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import Foundation

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
