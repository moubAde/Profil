//
//  ViewController.swift
//  Profil
//
//  Created by mohamed on 15/04/2020.
//  Copyright © 2020 mohamed. All rights reserved.
//

import UIKit
import Kingfisher

class ProfilController: UIViewController {

    @IBOutlet var imageView : UIImageView!
    @IBOutlet var name  : UILabel!
    @IBOutlet var email : UILabel!
    //@IBOutlet var buttonUpdate : UIButton!
    
    let URL_API="https://reqres.in/api/users/1"
    var profil: Profil?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let preferences = UserDefaults.standard
        let currentProfilKey = "currentProfil"
        if preferences.object(forKey: currentProfilKey) != nil {
            profil = preferences.object(forKey: currentProfilKey) as! Profil
            print("preferences")
            print(profil)
        }*/
        
        if(profil == nil){
            self.callApi(callback: loadProfil)
        }else{
            self.loadProfil(profil: profil!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profilDetail = segue.destination as! ProfilDetailController
        profilDetail.profil = self.profil
    }
    
    func callApi(callback: @escaping(Profil) -> Void ){
        if let url = URL(string: URL_API){
            URLSession.shared.dataTask(with: url){
                data, res, err in
                    if let data = data {
                        let json_profil = try? JSONDecoder().decode(Profil.self, from: data)
                        //print(json_profil?.data)
                        self.profil=json_profil
                        //print(self.profil)
                        //self.loadProfil(profil: self.profil!)
                        callback(self.profil!)
                    }
            }.resume()
            print("finished")
        }
   }
    
    func loadProfil(profil: Profil){
        DispatchQueue.main.async {
            self.name.text = profil.data.first_name + " " + profil.data.last_name
            self.email.text=profil.data.email
            let url = URL(string:profil.data.avatar)
            self.imageView.kf.setImage(with: url)
        }
        
        /*let preferences = UserDefaults.standard
        let currentProfil = self.profil
        let currentProfilKey = "currentProfil"
        preferences.set(currentProfil, forKey: currentProfilKey)*/
    }
}

