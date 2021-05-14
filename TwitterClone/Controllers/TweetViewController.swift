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
    
    var vc: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tweetButton(_ sender: UIButton) {
        guard let tweet = tweetTextView.text else{
            return
        }
        
        if !tweet.isEmpty{
            guard let uid = Auth.auth().currentUser?.uid else{ return }
            let db = Firestore.firestore()
            
            let docRef: DocumentReference? = db.collection("users").document(uid)
            
            DispatchQueue.global().async {
                docRef?.getDocument{ (document, error) in
                    if let document = document, document.exists{
                        let firstName = document.get("firstname")
                        let lastName = document.get("lastname")
                        let userName = document.get("username")
                        
                        docRef?.collection("tweets").addDocument(data: ["dateCreated": Date(), "firstname": firstName!, "lastname": lastName!, "username": userName!, "tweet" : tweet, "length" : tweet.count], completion: { (error) in
                            if  error != nil {
                                print("Error saving tweet")
                            } else{
                                print("Document added")
                                
                            }
                        })
                    }
                }
            }
            //instanceOfFeedVC.tableView.reloadData()
            self.performSegue(withIdentifier: "tweetID", sender: self)
            self.viewWillAppear(true)
            //self.instanceOfFeedVC.tableView.reloadData()
            self.dismiss(animated: true){
                //FeedViewController.loadTweets(<#T##self: FeedViewController##FeedViewController#>)
            }
        }
    }
    
//    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async {
//
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? FeedViewController {
                DispatchQueue.main.async {
                    firstVC.tableView.reloadData()
                }
        }
    }

}
