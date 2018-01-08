//
//  ViewController.swift
//  IF26_project
//
//  Created by Corentin Fievet on 06/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public static var userConnecte: User? = nil
    
    //Inscription
      
    @IBOutlet weak var MrMme: UISegmentedControl!
    
    @IBOutlet weak var nom: UITextField!
    
    @IBOutlet weak var nomMarital: UITextField!
    
    @IBOutlet weak var prenom: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var identifiant: UITextField!
    
    @IBOutlet weak var motDePasse: UITextField!
 
    
    @IBOutlet weak var confirmerMotDePasse: UITextField!
     
    @IBOutlet weak var labelInscription: UILabel!
    
    @IBAction func inscriptionButton() {
        let nom: String? = self.nom.text
        let nomMarital: String? = self.nomMarital.text
        let prenom: String? = self.prenom.text
        let email: String? = self.email.text
        let identifiant: String? = self.identifiant.text
        let motDePasse: String? = self.motDePasse.text
        let confirmerMotDePasse: String? = self.confirmerMotDePasse.text
        
        if(nom != "" && nom != nil && prenom != nil && prenom != "" && email != nil && email != "" && identifiant != nil && identifiant != "" && motDePasse != nil && motDePasse != "")
        {
            if(motDePasse == confirmerMotDePasse)
            {
                if(User.getUserByEmail(email: email!) != nil)
                {
                    self.labelInscription.text = "Cet email est déjà utilisé"
                }
                else if(User.getUserByLogin(login: identifiant!) != nil)
                {
                    self.labelInscription.text = "Cet identifiant est déjà utilisé"
                }
                else
                {
                    var genre: Int = 0
                    if(self.MrMme.selectedSegmentIndex == 1)
                    {
                        genre = 1
                    }
                    
                    User.insertNewUser(name: nom!, prenom: prenom!, nomMarital: nomMarital, email: email!, identidiant: identifiant!, motDePasse: motDePasse!, idGenre: genre)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "connexion") as! ViewController
                    navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
            else
            {
                self.labelInscription.text = "Les mots de passe ne correspondent pas"
            }
        }
        else
        {
            self.labelInscription.text = "L'ensemble des informations ne sont pas complétes"
        }
    }
    
    @IBAction func insertUser() {
        let nom: String? = self.nom.text
        let nomMarital: String? = self.nomMarital.text
        let prenom: String? = self.prenom.text
        let email: String? = self.email.text
        let identifiant: String? = self.identifiant.text
        let motDePasse: String? = self.motDePasse.text
        let confirmerMotDePasse: String? = self.confirmerMotDePasse.text
        
        self.email.backgroundColor = .white
        self.identifiant.backgroundColor = .white
        self.motDePasse.backgroundColor = .white
        self.confirmerMotDePasse.backgroundColor = .white
        
        var b: Bool = false
        var error: String = ""
        
        if(nom != "" && nom != nil && prenom != nil && prenom != "" && email != nil && email != "" && identifiant != nil && identifiant != "" && motDePasse != nil && motDePasse != "" && confirmerMotDePasse != nil && confirmerMotDePasse != "")
        {
        
            if(User.getUserByEmail(email: email!) != nil)
            {
                self.email.backgroundColor = .red
                error = "Cet email est déjà utilisé\n"
                b = true
            }
            
            if(User.getUserByLogin(login: identifiant!) != nil)
            {
                error += "Cet identifiant est déjà utilisé\n"
                self.identifiant.backgroundColor = .red
                b = true
            }
            
            if(motDePasse != confirmerMotDePasse)
            {
                error += "Les mots de passe ne correspondent pas\n"
                self.motDePasse.backgroundColor = .red
                self.confirmerMotDePasse.backgroundColor = .red
                b = true
            }
            
            if(b == false)
            {
                var genre: Int = 1
                if(self.MrMme.selectedSegmentIndex == 1)
                {
                    genre = 2
                }
                
                User.insertNewUser(name: nom!, prenom: prenom!, nomMarital: nomMarital, email: email!, identidiant: identifiant!, motDePasse: motDePasse!, idGenre: genre)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "connexion") as! ViewController
                navigationController?.pushViewController(vc, animated: true)
        
            }
            else
            {
                self.labelInscription.text = error
            }
        }
        else
        {
            self.labelInscription.text = "L'ensemble des informations ne sont pas complétes"
        }
    }
    
    //Connexion
    @IBOutlet weak var emailConnexion: UITextField!
    
    @IBOutlet weak var motDePasseConnexion: UITextField!
    
    @IBOutlet weak var labelConnexion: UILabel!
    
    @IBAction func connexion(_ sender: UIButton) {
        let email : String? = self.emailConnexion.text
        let _ : String? = self.motDePasseConnexion.text
        
        if(email != nil && email != "")
        {
            let user: User? = User.getUserByEmail(email: email!)
            
            if(user != nil)
            {
                ViewController.userConnecte = user!
                self.labelConnexion.text = "Bonjour \(String(describing: ViewController.userConnecte))"
                
                //Gestion du passage d'un controlView à un autre
                let storyboard = UIStoryboard(name: "Main", bundle: nil)                
                let vc = storyboard.instantiateViewController(withIdentifier: "compte") as! CompteTableViewController
                navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                self.labelConnexion.text = "Erreur d'email ou de mot de passe"
                self.emailConnexion.backgroundColor = .red
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.createDatabase()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



