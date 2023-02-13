//
//  MainViewModel.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class MainViewModel {
    var photos: Photos?
    
    var updateUi: (() -> Void)?
    
    init() {
        searchPhotos(searchString: "KnowIT")
    }
    
    func flowLayout(viewSize: CGSize) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: viewSize.width / 2 - 8, height: 200)
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        return flowLayout
    }
    
    func searchPhotos(searchString: String) {
        let api = FlickrAPI()
        
        let formattedSearchString = searchString.replacingOccurrences(of: " ", with: ",")
        
        Task {
            do {
                let newPhotos = try await api.searchFor(searchString: formattedSearchString).photos
                
                photos = newPhotos
                
            } catch {
                print("Error: \(error)")
            }
            updateUi?()
        }
    }
}
