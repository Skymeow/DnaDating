//
//  PersonalityViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import CoreData

class PersonalityViewController: UIViewController {
    let coredataStack = CoreDataStack.instance
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var subContentView: UIView!
    
    @IBOutlet weak var neuroticism: UITextField!
    
    var neuroticismData: String?
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let traitData = Traits(context: coredataStack.privateContext)
        traitData.nero = neuroticism.text ?? "0"
        coredataStack.saveTo(context: coredataStack.privateContext)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.neuroticismData = neuroticism.text! ?? "0"
//        let traitData = Traits(context: coredataStack.privateContext)
//        traitData.nero = self.neuroticismData
//        coredataStack.saveTo(context: coredataStack.privateContext)
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
