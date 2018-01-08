//
//  ViewControllerInscriptionConnexion.swift
//  IF26_project
//
//  Created by Corentin Fievet on 09/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class ViewControllerInscriptionConnexion: UIViewController {
    
    public static var userConnecte: User? = nil
    
    @IBOutlet weak var nom: UITextField!
    
    @IBOutlet weak var nomMarital: UITextField!
    
    @IBOutlet weak var prenom: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var identifiant: UITextField!
    
    @IBOutlet weak var motDePasse: UITextField!
    
    @IBOutlet weak var confimerMotDePasse: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func inscription() {
        let nom: String? = self.nom.text
        let nomMarital: String? = self.nomMarital.text
        let prenom: String? = self.prenom.text
        let email: String? = self.email.text
        let identifiant: String? = self.identifiant.text
        let motDePasse: String? = self.motDePasse.text
        let confirmerMotDePasse: String? = self.confimerMotDePasse.text
        
        if(nom != "" && nom != nil && prenom != nil && prenom != "" && email != nil && email != "" && identifiant != nil && identifiant != "" && motDePasse != nil && motDePasse != "" && confirmerMotDePasse != nil && confirmerMotDePasse != "")
        {
            if(motDePasse == confirmerMotDePasse)
            {
                if(User.getUserByEmail(email: email!) != nil)
                {
                    self.errorLabel.text = "Cet email est déjà utilisé"
                }
                else if(User.getUserByLogin(login: identifiant!) != nil)
                {
                    self.errorLabel.text = "Cet identifiant est déjà utilisé"
                }
                else
                {
                    User.insertNewUser(name: nom!, prenom: prenom!, nomMarital: nomMarital, email: email!, identidiant: identifiant!, motDePasse: motDePasse!)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "connexion") as! ViewControllerInscriptionConnexion
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            else
            {
                self.errorLabel.text = "Les mots de passe ne correspondent pas"
            }
        }
        else
        {
            self.errorLabel.text = "L'ensemble des informations ne sont pas complétes"
        }
    }
    
    @IBOutlet weak var emailConnexion: UITextField!
    
    @IBOutlet weak var motDePasseConnexion: UITextField!
    
    @IBOutlet weak var labelConnexion: UILabel!
    
    
    @IBAction func connexion(_ sender: UIButton) {
        let email : String? = self.emailConnexion.text
        let motDePasse : String? = self.motDePasseConnexion.text
        
        if(email != nil && email != "")
        {
            let user: User? = User.getUserByEmail(email: email!)
            
            if(user != nil)
            {
                ViewController.userConnecte = user!
                self.labelConnexion.text = "Bonjour \(ViewController.userConnecte)"
                
                //Gestion du passage d'un controlView à un autre
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "compte") as! CompteTableViewController
                navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                self.labelConnexion.text = "Erreur d'email ou de mot de passe"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.createDatabase()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
