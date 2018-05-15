//
//  ParksPageController.swift
//  Skatepark Atlas
//
//  Created by Chase Tillar on 1/2/18.
//  Copyright © 2018 Chase Tillar. All rights reserved.
//

import UIKit
import SwiftyJSON
import GooglePlaces

class ParksPageController: UIPageViewController {
    
    var selectedCity = String()
    
    private(set) lazy var parksViewControllers: [UIViewController] = {
        return [self.newParkViewController(color: "Parks")]
        
    }()
    
    private func newParkViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(color)VC")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstParkVC = parksViewControllers.first {
            setViewControllers([firstParkVC], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

// MARK: UIPageViewControllerDataSource

extension ParksPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
