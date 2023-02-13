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
    private var orderedViewControllers = [UIViewController]()
    
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
        
        let firstViewController = ImageViewController(photo: selectedPhoto)
        orderedViewControllers.append(firstViewController)
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return UIViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return UIViewController()
    }
}
