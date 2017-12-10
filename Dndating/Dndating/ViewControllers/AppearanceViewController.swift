//
//  FirstPageViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/9/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import CoreData

class AppearanceViewController: UIViewController {
    let coredataStack = CoreDataStack.instance
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var subContentView: UIView!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var motion: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var freckles: UITextField!
    
    var weightData: String?
    var motionData: String?
    var heightData: String?
    var frecklesData: String?
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let traitData = Traits(context: coredataStack.privateContext)
        traitData.weight = weight.text ?? "0"
        traitData.height = height.text ?? "0"
        traitData.motion = motion.text ?? "0"
        traitData.freckles = freckles.text ?? "0"
        
        coredataStack.saveTo(context: coredataStack.privateContext)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.weightData = weight.text ?? "0"
//        self.motionData = motion.text ?? "0"
//        self.heightData = height.text ?? "0"
//        self.frecklesData = freckles.text ?? "0"
//        let traitData = Traits(context: coredataStack.privateContext)
//        traitData.weight = weightData
//        traitData.height = heightData
//        traitData.motion = motionData
//        traitData.freckles = frecklesData
//
//        coredataStack.saveTo(context: coredataStack.privateContext)
//
    }

    override func viewDidLayoutSubviews()
    {
        let scrollViewBounds = scrollView.bounds
        let containerViewBounds = subContentView.bounds
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height;
        scrollViewInsets.top -= subContentView.bounds.size.height;
        
        scrollViewInsets.bottom = scrollViewBounds.size.height
        scrollViewInsets.bottom -= subContentView.bounds.size.height;
        scrollViewInsets.bottom += 1
        
        scrollView.contentInset = scrollViewInsets
    }
}
