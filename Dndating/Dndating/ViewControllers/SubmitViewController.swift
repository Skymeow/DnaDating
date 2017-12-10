//
//  SubmitViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import CoreData

class SubmitViewController: UIViewController {
    
    let coredataStack = CoreDataStack.instance
    var traitsResult: Traits?
    var weightData: Int?
    var motionData: Int?
    var heightData: Int?
    var frecklesData: Int?
//    var matchedUser: Matched?
    
    @IBAction func submitTapped(_ sender: UIButton) {
        print(traitsResult)
        let weight1 = Int(traitsResult!.weight!)! - 1
        let motion1 = Int(traitsResult!.motion!)! - 1
        let height1 = Int(traitsResult!.height!)! - 1
        let freckles1 = Int(traitsResult!.freckles!)! - 1
//        let nero1 = Int(traitsResult!.nero!)! - 1
        let traitData = Trait(weight: weight1, motionSickness: motion1, height: height1, freckles: freckles1, neuroticism: 1)
        Networking.instance.fetch(route: .traits, method: "POST", headers: ["Content-Type": "application/json"], data: traitData){ (data, response) in
            if response == 200 {
                print(data, response)
                let matched = try? JSONDecoder().decode(Matched.self, from: data)
                print(matched!.match[0].userData.img)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let matchedVC = storyBoard.instantiateViewController(withIdentifier: "matchedVC") as! MatchedViewController
                matchedVC.matchedUsers = (matched?.match)!
                DispatchQueue.main.async {
                    self.present(matchedVC, animated: true, completion: nil)
                }

            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetch = NSFetchRequest<Traits>(entityName: "Traits")
        do {
            let result = try coredataStack.privateContext.fetch(fetch)
            self.traitsResult = result.first
//            print(traitsResult)
        }catch let error {
            print(error)
        }
    }


}
