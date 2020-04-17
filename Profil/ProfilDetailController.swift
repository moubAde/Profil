//
//  ProfilDetailController.swift
//  Profil
//
//  Created by mohamed on 16/04/2020.
//  Copyright © 2020 mohamed. All rights reserved.
//

import UIKit

class ProfilDetailController: UIViewController {

    @IBOutlet var firstName  : UITextField!
    @IBOutlet var lastName : UITextField!
    @IBOutlet var valider : UIButton!
    
    var profil: Profil!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valider.isEnabled = false
        //print("profil in detail")
        //print(profil)
    }
    
    @IBAction func submit (sender: UIButton){
        //print(firstName.text)
        //print(lastName.text)
        
        profil.data.first_name = firstName.text!
        profil.data.last_name = lastName.text!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profil = storyboard.instantiateViewController(withIdentifier: "profil") as! ProfilController
        profil.profil = self.profil
        navigationController?.show(profil, sender: self)
    }
    
    @IBAction func check(sender: UITextField){
        if( (firstName.text != nil && firstName.text != "" ) && (lastName.text != nil && lastName.text != "" ) ){
            valider.isEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


