//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/5/21.
//

import UIKit
import Firebase
import FirebaseAuth

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tweetButton.isEnabled = false
    }
    
    @IBAction func tweetButton(_ sender: UIButton) {
        guard let tweet = tweetTextView.text else{
            return
        }
        
        if !tweet.isEmpty{
            guard let uid = Auth.auth().currentUser?.uid else{ return }
            let db = Firestore.firestore()
            
            let docRef: DocumentReference? = db.collection("users").document(uid)
            
            docRef?.getDocument{ (document, error) in
                if let document = document, document.exists{
                    let firstName = document.get("firstname")
                    let lastName = document.get("lastname")
                    let userName = document.get("username")
                    
                    docRef?.collection("tweets").addDocument(data: ["dateCreated": Date(), "firstname": firstName!, "lastname": lastName!,
                                                                    "username": userName!, "tweet" : tweet, "length" : tweet.count],
                                                             completion: { (error) in
                                                                if  error != nil {
                                                                    print("Error saving tweet")
                                                                } else{
                                                                    print("Document added")
                                                                }
                                                             })
                }
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }

}
