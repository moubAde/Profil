//
//  Profil.swift
//  Profil
//
//  Created by mohamed on 16/04/2020.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation

struct Profil: Codable{
    var data: Data
    var ad: Ad
    
    init(data: Data, ad: Ad){
        self.data=data
        self.ad=ad
    }
}
