//
//  UserTweetCell.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/13/21.
//

import Foundation
import UIKit

class UserTweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetLabel: UITextView!
    
    override func prepareForReuse() {
        tweetLabel.text = ""
}
    
    class UserTweetInfo{
        let tweet : String
        
        init(tweet: String) {
            self.tweet = tweet
        }
    }
    
}
