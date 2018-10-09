//
//  Friend.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-07.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit

class Friend: NSObject {
    
    var UID: String?
    var nickname: String?
    
    init(uid: String, nickname: String) {
        self.UID = uid
        self.nickname = nickname
    }
}
