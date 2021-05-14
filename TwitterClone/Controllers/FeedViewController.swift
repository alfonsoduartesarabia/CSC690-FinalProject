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
    
    
  
    var tweets: [TweetTableViewCell.TweetInfo] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateAuth()
        tableView.delegate = self
        tableView.dataSource = self
        loadTweets()
        //present(TweetViewController(), animated: true, completion: nil)
    }

    
    @IBAction func tweetButtonTapped(_ sender: Any) {
        
    }
    
    func loadTweets(){
       // guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        DispatchQueue.global().async {
            
            self.db.collectionGroup("tweets").getDocuments { (snapshot, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        //self.tweets.append(document.data() as NSDictionary)
                        //self.tweets.append(document.get("tweet") as! String)
                        let firstName = document.get("firstname") as! String
                        let lastName = document.get("lastname") as! String
                        let name = firstName + " " + lastName
                        var username = "@"
                        username += document.get("username") as! String
                        let tweet = document.get("tweet") as! String
                        let newTweetInfo = TweetTableViewCell.TweetInfo.init(name: name, username: username, tweet: tweet)
                        self.tweets.append(newTweetInfo)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetTableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel?.text = tweets[indexPath.row].name
        cell.usernameLabel?.text = tweets[indexPath.row].username
        cell.tweetLabel?.text = tweets[indexPath.row].tweet
        cell.tweetLabel?.isEditable = false
        return cell
    }
    
//    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
    
//    override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            tableView.reloadData()
//        }
    
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//            tableView.reloadData()
//           // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
//        }

}
