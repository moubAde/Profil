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
        
        if(profil == nil){
            profil=getPreferences()
            if(profil == nil){
                self.callApi(callback: loadProfil)
            }else{
                self.loadProfil(profil: profil!)
            }
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
                        self.profil=json_profil
                        callback(self.profil!)
                    }
            }.resume()
        }
   }
    
    func loadProfil(profil: Profil){
        DispatchQueue.main.async {
            self.name.text = profil.data.first_name + " " + profil.data.last_name
            self.email.text=profil.data.email
            let url = URL(string:profil.data.avatar)
            self.imageView.kf.setImage(with: url)
        }
        setPreferences(profil: profil)
    }
    
    func setPreferences(profil: Profil){
        let preferences = UserDefaults.standard
        preferences.set(profil.data.id, forKey: "id")
        preferences.set(profil.data.email, forKey: "email")
        preferences.set(profil.data.first_name, forKey: "first_name")
        preferences.set(profil.data.last_name, forKey: "last_name")
        preferences.set(profil.data.avatar, forKey: "avatar")
        
        preferences.set(profil.ad.company, forKey: "company")
        preferences.set(profil.ad.url, forKey: "url")
        preferences.set(profil.ad.text, forKey: "text")
    }
    
    func getPreferences() -> Profil?{
        	
        let preferences = UserDefaults.standard

        let id = preferences.object(forKey: "id") as? Int
        let email = preferences.object(forKey: "email") as? String
        let first_name = preferences.object(forKey: "first_name") as? String
        let last_name = preferences.object(forKey: "last_name") as? String
        let avatar = preferences.object(forKey: "avatar") as? String
        let company = preferences.object(forKey: "company") as? String
        let url = preferences.object(forKey: "url") as? String
        let text = preferences.object(forKey: "text") as? String
        
        if(id != nil && email != nil && first_name != nil && last_name != nil && avatar != nil && company != nil && url != nil && text != nil){
            let data = Data(id: id!, email: email!, first_name: first_name!, last_name: last_name!, avatar: avatar!)
            let ad = Ad( company: company!, url: url!, text: text!)
            
            let profil = Profil(data: data, ad: ad)
            return profil
        }
        return nil
    }
}

