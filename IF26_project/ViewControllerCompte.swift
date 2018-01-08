//
//  ViewControllerCompte.swift
//  IF26_project
//
//  Created by Corentin Fievet on 07/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class ViewControllerCompte: UIViewController {

    @IBOutlet weak var numeroCompte: UITextField!
    
    @IBOutlet weak var montant: UITextField!
    
    @IBAction func ajouterCompte(_ sender: UIButton) {
        if(self.montant.text != nil && self.montant.text != "" && self.numeroCompte.text != nil && self.numeroCompte.text != "")
        {
            let montantInsert: Double? = Double(self.montant.text!)
            let numeroCompteInsert: String? = self.numeroCompte.text
            
            Compte.insertNewCompte(numero: numeroCompteInsert!, capital: montantInsert!)
            //Compte.getCompteById(idUser: ViewController.userConnecte!.getIdUser())
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "compte") as! CompteTableViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
