//
//  PostData.swift
//  Instagram
//
//  Created by 橋本養子 on 2017/09/15.
//  Copyright © 2017年 kotokotokoto. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String]  = []
    
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64Encoded: imageString!, options: .ignoreUnknownCharacters)! as Data)
        
            self.name = valueDictionary["name"] as? String
            
            self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = NSDate(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeID in self.likes {
            if likeID == myId {
                self.isLiked = true
                break
            }
        }
        
        if let comments = valueDictionary["comments"] as? [String] {
            self.comments = comments
        }
    }
}
