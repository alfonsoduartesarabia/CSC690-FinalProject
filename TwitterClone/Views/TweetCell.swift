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
    
    
    
    // Create custom class to hold username, name, and tweet
    class UserTweetInfo{
//        let name: String
//        let userName: String
//        let tweet: String
//
//        init(name: String, userName: String, tweet: String) {
//            self.name = name
//            self.userName = userName
//            self.tweet = tweet
//        }
//
        
        var userTweets: NSDictionary = [:]
        
        init(userTweets: NSDictionary) {
            self.userTweets = userTweets
        }
    }
    
    // Iterate through the custom class object array
//    func printInfo(tweets: [UserTweetInfo]){
//        for tweetEntry in tweets{
//            print("[Name: \(tweetEntry.name), Username: \(tweetEntry.userName), Tweet: \(tweetEntry.tweet)]")
//        }
//    }
    
    
    
//    override func prepareForReuse() {
//        <#code#>
//    }
    
}
