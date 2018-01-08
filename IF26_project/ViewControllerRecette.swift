//
//  ViewControllerRecette.swift
//  IF26_project
//
//  Created by Corentin Fievet on 07/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class ViewControllerRecette: UIViewController {

    @IBOutlet weak var checkedRecette: UISegmentedControl!
    
    @IBOutlet weak var depenseRectte: UISegmentedControl!
    
    @IBOutlet weak var montant: UITextField!
    
    @IBOutlet weak var commentaire: UITextField!
    
    @IBOutlet weak var checkValider: UISegmentedControl!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func ajouterRecette(_ sender: UIButton) {
        
        if(montant.text != nil && montant.text != "" && commentaire.text != nil && commentaire.text != "")
        {
            if Double(montant.text!) != nil
            {
                let montant: Double?
                if(self.checkedRecette.selectedSegmentIndex == 0)
                {
                    montant = -Double(self.montant.text!)!
                }
                else
                {
                    montant = Double(self.montant.text!)
                }
                
                let etat: Int
                if(self.checkValider.selectedSegmentIndex == 0)
                {
                    etat = 1
                }
                else
                {
                    etat = 2
                    CompteTableViewController.compte!.updateCapital(montant: montant!)
                    CompteTableViewController.compte = Compte.getCompteById(idCompte: CompteTableViewController.compte!.getIdCompte())
                }
                
                let commentaire: String? = self.commentaire.text!
                
                Recette.insertNewRecette(commentaire: commentaire!, montant: montant!, etat: etat)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "recette") as! RecetteTableViewController
                navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                self.errorLabel.text = "Le montant saisi n'est pas valide"
            }
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
