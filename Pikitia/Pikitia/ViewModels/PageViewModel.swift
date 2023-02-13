//
//  PageViewModel.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

final class PageViewModel {
    var photos: [Photo]
    var selectedPhoto: Photo
    var orderedViewControllers = [ImageViewController]()
    
    init(photos: [Photo], selectedPhoto: Photo, orderedViewControllers: [ImageViewController] = [ImageViewController]()) {
        self.photos = photos
        self.selectedPhoto = selectedPhoto
        self.orderedViewControllers = orderedViewControllers
        
        guard let currentImageIndex = photos.firstIndex(of: selectedPhoto) else { return }
        
        if currentImageIndex > 0 {
            let firstImage = photos[currentImageIndex - 1]
            self.orderedViewControllers.append(ImageViewController(photo: firstImage))
        }
        
        let secondImage = photos[currentImageIndex]
        self.orderedViewControllers.append(ImageViewController(photo: secondImage))
        
        if currentImageIndex < numberOfPhotos - 1 {
            let thirdImage = photos[currentImageIndex + 1]
            self.orderedViewControllers.append(ImageViewController(photo: thirdImage))
        }
    }
    
    var firstViewController: UIViewController? {
        guard let firstViewController = orderedViewControllers.first(where: { $0.photo == selectedPhoto}) else { return nil }
        return firstViewController
    }
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    func viewControllerBefore(viewController: UIViewController) -> UIViewController? {
        guard let imageViewController = viewController as? ImageViewController,
              let currentIndex = orderedViewControllers.firstIndex(of: imageViewController),
              currentIndex > 0
        else { return nil }
        
        var previousIndex = currentIndex - 1
        
        if currentIndex == 1,
           let currentImageIndex = photos.firstIndex(of: imageViewController.photo),
           currentImageIndex - 2 >= 0 {
            orderedViewControllers.insert(ImageViewController(photo: photos[currentImageIndex - 2]), at: 0)
            previousIndex += 1
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func viewControllerAfter(viewController: UIViewController) -> UIViewController? {
        guard let imageViewController = viewController as? ImageViewController,
              let currentIndex = orderedViewControllers.firstIndex(of: imageViewController),
              currentIndex < orderedViewControllers.count - 1
        else { return nil }
        
        if currentIndex == orderedViewControllers.count - 2,
           let currentImageIndex = photos.firstIndex(of: imageViewController.photo),
           currentImageIndex + 2 < numberOfPhotos {
            orderedViewControllers.append(ImageViewController(photo: photos[currentImageIndex + 2]))
        }
        
        return orderedViewControllers[currentIndex + 1]
    }
}
