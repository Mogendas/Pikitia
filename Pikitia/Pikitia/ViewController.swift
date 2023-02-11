//
//  ViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()  {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = FlickrAPI()
        
        Task {
            do {
                let photos = try? await api.searchFor(searchString: "Beach")
                
                print("Photos: \(photos)")
            }
        }
    }
}

