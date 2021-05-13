//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/10/21.
//

import Foundation
import UIKit

class TweetTableViewCell: UITableViewCell {
    
    // Labels for username, full name, and tweets
    // sets the labels texts from the firestore base
    // use main async ??
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
        override func prepareForReuse() {
            nameLabel.text = ""
            usernameLabel.text = ""
            tweetLabel.text = ""
    }
    
    class TweetInfo {
        let name : String
        let username : String
        let tweet : String
        
        init(name : String, username: String, tweet: String) {
            self.name = name
            self.username = username
            self.tweet = tweet
        }
    }
    
}
