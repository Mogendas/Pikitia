//
//  PageViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class PageViewController: UIPageViewController {
    private var photos: [Photo]
    private var selectedPhoto: Photo
    private var orderedViewControllers = [ImageViewController]()
    
    init(photos: [Photo], selectedPhoto: Photo) {
        self.photos = photos
        self.selectedPhoto = selectedPhoto
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        navigationController?.isNavigationBarHidden = false
        photos.forEach { photo in
            orderedViewControllers.append(ImageViewController(photo: photo))
        }
        
        guard let firstViewController = orderedViewControllers.first(where: { $0.photo == selectedPhoto}) else { return }
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let imageViewController = viewController as? ImageViewController,
              let currentIndex = orderedViewControllers.firstIndex(of: imageViewController),
              currentIndex > 0
        else { return nil }
        
        return orderedViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let imageViewController = viewController as? ImageViewController,
              let currentIndex = orderedViewControllers.firstIndex(of: imageViewController),
              currentIndex < orderedViewControllers.count - 1
        else { return nil }
        
        return orderedViewControllers[currentIndex + 1]
    }
}
