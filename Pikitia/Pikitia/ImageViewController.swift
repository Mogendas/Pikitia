//
//  ImageViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        
        super.init(nibName: "ImageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: photo.imageURLString) {
            imageView.load(url: url, placeholder: nil)
        }
    }
}
