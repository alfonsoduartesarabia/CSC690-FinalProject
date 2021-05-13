//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/5/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    // User clicks on login button
    @IBAction func loginTapped(_ sender: Any) {
        email.resignFirstResponder()
        password.resignFirstResponder()
        
        guard let emailText = email.text, let passwordText = password.text,
              !emailText.isEmpty, !passwordText.isEmpty
              else {
            alertUserLoginError()
            return
        }
        
        // Firebase login
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { [weak self] authResult, error in
            guard let user = authResult, let  _ = self else {
            print("Error loging in with email: \(emailText)")
            return }
            
            print("Logged in \(user)")
            //strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            //self?.transitiontoHomeScreen()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        
    }
    
    // Alert for when user enter incorrect information
    func alertUserLoginError(){
        let alert = UIAlertController(title: "LoginError", message: "Please enter all information to log in.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func transitiontoHomeScreen(){
        let feedVC = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.feedViewController) as? FeedViewController
        
        view.window?.rootViewController = feedVC
        view.window?.makeKeyAndVisible()
    }
    
}
