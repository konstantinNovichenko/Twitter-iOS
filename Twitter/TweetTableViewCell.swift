//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Konstantin Novichenko on 9/30/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var favorited: Bool = false
    var tweetId: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        let tobeFavorited = !favorited
        if(tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: self.tweetId, success: {
                self.setFavorite(true)
            }, failure: {
                (error) in
                print("Favorite did not succeed: \(error)")
            } )
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: self.tweetId, success: {
                self.setFavorite(false)
            }, failure: {
                (error) in
                print("Unfavorite did not succeed: \(error)")
            } )
        }
    }
    
    func setFavorite(_ isFavorited: Bool) {
        self.favorited = isFavorited
        if (isFavorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    @IBAction func retweet(_ sender: UIButton) {
        TwitterAPICaller.client?.retweet(tweetId: self.tweetId, success: {
            self.setRetweeted(true)
        }, failure: {
            (error) in
            print("Retweet did not succeed: \(error)")
        } )
    }
    
}
