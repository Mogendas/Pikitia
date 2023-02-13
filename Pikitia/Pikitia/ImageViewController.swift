//
//  ImageViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class ImageViewController: UIViewController {
    private(set) var viewModel: ImageViewModel

    @IBOutlet private weak var imageView: UIImageView!
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "ImageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: viewModel.imageURLString) {
            imageView.load(url: url, placeholder: nil)
        }
    }
}
