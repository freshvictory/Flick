//
//  PageViewController.swift
//  Flick
//
//  Created by Justin Renjilian on 8/3/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {
    
    var redditViewControllers: [UIViewController] = [UIViewController]()
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAllViewControllers()
        
        dataSource = self
        let firstViewController = redditViewControllers[currentIndex]
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        
//        for gr in firstViewController.view.gestureRecognizers! {
//            gr.delegate = self
//        }
    }
    
    func createRedditViewController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "redditViewController")
    }
    
    func createAllViewControllers() {
//        for post in Reddit.posts {
            let view = createRedditViewController() as? RedditViewController
//            view?.url = post.url
            redditViewControllers.append(view!)
//        }
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("attempting to scroll left")
        guard let viewControllerIndex = redditViewControllers.index(of: viewController) else {
            return nil
        }
        currentIndex = viewControllerIndex
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard redditViewControllers.count > previousIndex else {
            return nil
        }
//
//        previousButton.enabled = currentIndex != 0
//        nextButton.enabled = currentIndex != Reddit.posts.count - 1
//        navigationItem.title = Reddit.posts[currentIndex].title
//        setupButtons()
        return redditViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("attempting to scroll right")
        guard let viewControllerIndex = redditViewControllers.index(of: viewController) else {
            return nil
        }
        
        currentIndex = viewControllerIndex
        
        let nextIndex = viewControllerIndex + 1
        let count = redditViewControllers.count
        
        guard count != nextIndex else {
            return nil
        }
        
        guard count > nextIndex else {
            return nil
        }
//        nextButton.enabled = nextIndex != Reddit.posts.count - 1
//        previousButton.enabled = currentIndex != 0
//        navigationItem.title = Reddit.posts[currentIndex].title
//        setupButtons()
        return redditViewControllers[nextIndex]
    }
    
    // MARK: Gesture Recognizer Delegate
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        print("deciding if to gesture")
//        if let gr = gestureRecognizer as? UIPanGestureRecognizer {
//            if Vector.vertical(gr.translationInView(self.view)) {
//                print("decided not to gesture")
//                return false
//            }
//        }
//        return true
//    }
}
