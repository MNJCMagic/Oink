//
//  User.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-07.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var nickname: String?
    var UID: String?
    var createdOinks: [Oink]?
    var receivedOinks: [Oink]?
    var friends: [Friend]?

    init(nickname: String, UID: String, createdOinks: [Oink]?, receivedOinks: [Oink]?, friends: [Friend]?) {
        self.nickname = nickname
        self.UID = UID
        self.createdOinks = createdOinks
        self.receivedOinks = receivedOinks
        self.friends = friends
    }
}
