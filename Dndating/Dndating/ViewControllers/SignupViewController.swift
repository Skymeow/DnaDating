//
//  SignupViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/9/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {
    
    var username: String!
    var email: String!
    var password: String!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        print("sign up tapped")
        self.username = self.usernameTextfield.text
        self.email = self.emailTextfield.text
        self.password = self.passwordTextfield.text
        let user = User(username: self.username, email: self.email, password: self.password)
        Networking.instance.fetch(route: .usersSignup, method: "POST", headers: ["Content-Type": "application/json"], data: user) { (data, response) in
//            let parsedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print(parsedData)
            print(data, response)
            if response == 200 {
                
                 UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(true, forKey: "isUserSignedup")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let firstPageVC = storyBoard.instantiateViewController(withIdentifier: "toFirstPage") as! FirstPageViewController
                DispatchQueue.main.async {
                    self.present(firstPageVC, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
}
