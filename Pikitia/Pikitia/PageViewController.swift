//
//  PageViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-13.
//

import UIKit

class PageViewController: UIPageViewController {
    private var viewModel: PageViewModel
    
    init(viewModel: PageViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        navigationController?.isNavigationBarHidden = false
                
        guard let firstViewController = viewModel.firstViewController else { return }
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerBefore(viewController: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerAfter(viewController: viewController)
    }
}
