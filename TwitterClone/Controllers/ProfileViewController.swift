//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/5/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [UserTweetTableViewCell.UserTweetInfo] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadTweets()
    }
    
    func loadTweets(){
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        db.collection("users").document(uid).getDocument { (documents, error) in
            if let err = error{
                print("ERROR GETTING DOCUMENT \(err)")
            } else {
                if let document = documents, documents!.exists{
                    let firstName = document.get("firstname") as! String
                    let lastName = document.get("lastname") as! String
                    let name = firstName + " " + lastName
                    self.nameLabel.text = name
                    let username = document.get("username") as! String
                    self.usernameLabel.text = username
                }
            }
        }
        
        let docRef: DocumentReference? = db.collection("users").document(uid)
        
        DispatchQueue.main.async {
            
            docRef?.collection("tweets").getDocuments { (snapshot, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        let tweet = document.get("tweet") as! String
                        let TweetInfo = UserTweetTableViewCell.UserTweetInfo.init(tweet: tweet)
                        self.tweets.append(TweetInfo)
                    }
                }
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavController = storyboard.instantiateViewController(identifier: "HomeNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(homeNavController)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? UserTweetTableViewCell else {
            return UITableViewCell()
        }
        cell.tweetLabel?.text = tweets[indexPath.row].tweet
        cell.tweetLabel?.isEditable = false
        return cell
    }
    
}
