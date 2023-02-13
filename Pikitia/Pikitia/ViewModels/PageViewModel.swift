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
            let firstViewModel = ImageViewModel(photo: firstImage)
            self.orderedViewControllers.append(ImageViewController(viewModel: firstViewModel))
        }
        
        let secondImage = photos[currentImageIndex]
        let secondViewModel = ImageViewModel(photo: secondImage)
        self.orderedViewControllers.append(ImageViewController(viewModel: secondViewModel))
        
        if currentImageIndex < numberOfPhotos - 1 {
            let thirdImage = photos[currentImageIndex + 1]
            let viewModel = ImageViewModel(photo: thirdImage)
            self.orderedViewControllers.append(ImageViewController(viewModel: viewModel))
        }
    }
    
    var firstViewController: UIViewController? {
        guard let firstViewController = orderedViewControllers.first(where: { $0.viewModel.photo == selectedPhoto}) else { return nil }
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
           let currentImageIndex = photos.firstIndex(of: imageViewController.viewModel.photo),
           currentImageIndex - 2 >= 0 {
            let viewModel = ImageViewModel(photo: photos[currentImageIndex - 2])
            orderedViewControllers.insert(ImageViewController(viewModel: viewModel), at: 0)
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
           let currentImageIndex = photos.firstIndex(of: imageViewController.viewModel.photo),
           currentImageIndex + 2 < numberOfPhotos {
            let viewModel = ImageViewModel(photo: photos[currentImageIndex + 2])
            orderedViewControllers.append(ImageViewController(viewModel: viewModel))
        }
        
        return orderedViewControllers[currentIndex + 1]
    }
}
