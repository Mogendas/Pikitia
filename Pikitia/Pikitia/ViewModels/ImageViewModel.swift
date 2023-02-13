//
//  ImageViewModel.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import Foundation

final class ImageViewModel {
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var imageURLString: String {
        return photo.imageURLString
    }
}
