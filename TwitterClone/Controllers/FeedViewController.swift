//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/7/21.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //validateAuth()
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        validateAuth()
//       // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
//    }
    
    // check if user is logged in or not
//    private func validateAuth(){
//        if Auth.auth().currentUser == nil{
//            let vc = LoginViewController()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            present(nav, animated: false, completion: nil)
//        }
//    }

}
