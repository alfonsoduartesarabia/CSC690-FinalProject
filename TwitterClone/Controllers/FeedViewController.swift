//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/7/21.
//

import UIKit
import FirebaseAuth
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetButton: UIButton!
    
    var tweets: [NSDictionary] = []
    var docRef: DocumentReference? = nil
    let db = Firestore.firestore()
    //var listener: ListenerRegistration
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetTableViewCell else {
//            return UITableViewCell()
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
//        cell.textLabel?.text = tweets[indexPath.row]
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        validateAuth()
        //printUserData()
        loadTweets()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    
    func loadTweets(){
       // guard let uid = Auth.auth().currentUser?.uid else{ return }
    
//        var query = db.collection("users").getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
//                }
//        }
        
//        db.collectionGroup("tweets").whereField("tweet", isEqualTo: true).getDocuments { (snapshot, error) in
//            if let err = error {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in snapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    self.tweets = ["Name": document.data()]
//                }
//            }
//        }
        
        db.collectionGroup("tweets").getDocuments { (snapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.tweets.append(document.data() as NSDictionary)
                    
                }
            }
        }
        
    }
    
    func printUserData(){
            guard let uid = Auth.auth().currentUser?.uid else{ return }

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
    
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        validateAuth()
    //       // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
    //    }

}
