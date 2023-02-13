//
//  ImageViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    init(photo: Photo) {
        super.init(nibName: "ImageViewController", bundle: nil)
        
        if let url = URL(string: photo.imageURLString) {
            imageView.load(url: url, placeholder: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure(photo: Photo) {
        guard let url = URL(string: photo.imageURLString) else { return }
        imageView.load(url: url, placeholder: nil)
    }
}
