//
//  ImageCell.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 20
    }
    
    func configure(photo: Photo) {
        guard let url = URL(string: photo.imageURLString) else { return }
        imageView.load(url: url, placeholder: nil)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
