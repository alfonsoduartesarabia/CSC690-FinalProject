//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/7/21.
//

import UIKit
import FirebaseAuth
import Firebase

class FeedViewController: UIViewController {
    
    var docRef: DocumentReference? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        validateAuth()
        loadUserData()
    }
    
    func loadUserData(){
            guard let uid = Auth.auth().currentUser?.uid else{ return }
            let db = Firestore.firestore()

            db.collection("users").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    guard let text = document.get("username") as? String else{return}
                    print(text)
                } else {
                    print("Document does not exist")
                }
                
        }
        
    }
    
    func loadTweets(){
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        validateAuth()
//       // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
//    }
    
    // check if user is logged in or not
    private func validateAuth(){
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }

}
