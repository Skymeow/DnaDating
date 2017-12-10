//
//  LoginViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/9/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct Alerts {
    func loginError( controller: LoginViewController) {
        let logInAlert = UIAlertController(title: "Login error", message: "plz try again", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "try again", style: .default, handler: nil)
        logInAlert.addAction(cancel)
        controller.present(logInAlert, animated: true, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC = storyBoard.instantiateViewController(withIdentifier: "signupViewController") as! SignupViewController
        controller.present(signupVC, animated: true, completion: nil)
    }
}

class LoginViewController: UIViewController {
    
    let alert = Alerts()
    let defaults = UserDefaults.standard
    @IBAction func loginTapped(_ sender: UIButton) {
        let username = "test"
        let password = 123
        let post: [String: Any] = ["username": "\(username)", "password": password]
        Networking.instance.fetch(route: .usersSignup, method: "POST", headers: ["Content-Type": "application/json"], data: post) { (data, response) in
            //            let parsedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            //            print(parsedData)
            print(data, response)
            if response == 200 {
                self.defaults.set(true, forKey: "isUserLoggedIn")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let firstPageVC = storyBoard.instantiateViewController(withIdentifier: "toFirstPage") as! FirstPageViewController
                DispatchQueue.main.async{
                    self.present(firstPageVC, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.alert.loginError(controller: self)
                }
            }
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
}
