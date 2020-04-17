//
//  Data.swift
//  Profil
//
//  Created by mohamed on 16/04/2020.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation

struct Data: Codable{
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
    
    init(id: Int, email: String, first_name: String, last_name: String, avatar: String){
        self.id=id
        self.email=email
        self.first_name=first_name
        self.last_name=last_name
        self.avatar=avatar
    }
}
