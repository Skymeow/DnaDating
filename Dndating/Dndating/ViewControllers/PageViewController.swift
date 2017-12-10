//
//  PageViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/9/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        dataSource = self 
        delegate = self
        
        setViewControllers([getStepOne()], direction: .forward, animated: true, completion: nil)
    }
    
    func getStepOne() -> AppearanceViewController {
        return storyboard!.instantiateViewController(withIdentifier: "appearanceVC") as! AppearanceViewController
    }

    func getStepTwo() -> PersonalityViewController {
        return storyboard!.instantiateViewController(withIdentifier: "personalityVC") as! PersonalityViewController
    }

    func getStepThree() -> SubmitViewController {
        return storyboard!.instantiateViewController(withIdentifier: "submitVC") as! SubmitViewController
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
//
//// MARK: - UIPageViewControllerDataSource methods
//
extension PageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is PersonalityViewController {
            // 2 -> 1
            return getStepOne()
        } else if viewController is SubmitViewController {
            return getStepTwo()
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is AppearanceViewController {
            // 1 -> 2
//            AppearanceViewController.motionData =
            return getStepTwo()
        } else if viewController is PersonalityViewController {
            return getStepThree()
        } else {
            return nil
        }
    }

    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }

    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension PageViewController: UIPageViewControllerDelegate {}

