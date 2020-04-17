//
//  Ad.swift
//  Profil
//
//  Created by mohamed on 16/04/2020.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation


struct Ad: Codable{
    var company: String
    var url: String
    var text: String
    
    init(company: String, url: String, text: String){
        self.company=company
        self.url=url
        self.text=text
    }
}
