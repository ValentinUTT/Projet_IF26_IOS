//
//  ViewControllerModificationRecette.swift
//  IF26_project
//
//  Created by Corentin Fievet on 09/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class ViewControllerModificationRecette: UIViewController {

    @IBOutlet weak var check_recette: UISegmentedControl!
    
    @IBOutlet weak var montantTextEdit: UITextField!
    
    @IBOutlet weak var commentaireTextEdit: UITextField!
    
    @IBOutlet var vcheck_vaider: UIView!
    
    @IBOutlet weak var validerEnAttente: UISegmentedControl!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func modification(_ sender: UIButton) {
        
        if(self.commentaireTextEdit.text != "" && self.commentaireTextEdit.text != nil && self.montantTextEdit.text != "" && self.montantTextEdit.text != nil)
        {
            let montant: Double?
            if(self.check_recette.selectedSegmentIndex == 0)
            {
                montant = -Double(self.montantTextEdit.text!)!
            }
            else
            {
                montant = Double(self.montantTextEdit.text!)
            }
            
            var idEtat: Int = 1
            if(self.validerEnAttente.selectedSegmentIndex == 1)
            {
                idEtat = 2
            }
            
            let recette: Recette = RecetteTableViewController.recette!
            recette.updateRecette(montant: montant!, commentaire: self.commentaireTextEdit.text!, idEtat: idEtat)
            
            let result: Double = RecetteTableViewController.recette!.getMontantRecette() - montant!
            /*if(RecetteTableViewController.recette!.getMontantRecette() > montant!)
            {
                result = RecetteTableViewController.recette!.getMontantRecette() - montant!
            }*/
            /*else
            {
                result = montant! - RecetteTableViewController.recette!.getMontantRecette()
            }*/
            
            if(idEtat == 2)
            {
                CompteTableViewController.compte!.updateCapital(montant: -result)
            }
            
            RecetteTableViewController.recette = Recette.getRecetteById(idRecette: RecetteTableViewController.recette!.getIdRecette())
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "consultationRecette") as! ViewControllerConsultationRecette
            navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            self.errorLabel.text = "L'ensemble des données saisies ne sont pas correctes"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recette: Recette = RecetteTableViewController.recette!
        
        if(recette.getMontantRecette() < 0)
        {
            self.check_recette.selectedSegmentIndex = 0
            self.montantTextEdit.text = String(-recette.getMontantRecette())
        }
        else
        {
            self.check_recette.selectedSegmentIndex = 1
            self.montantTextEdit.text = String(recette.getMontantRecette())
        }
        
        if(recette.getEtatRecette() == 1)
        {
            self.validerEnAttente.selectedSegmentIndex = 0
        }
        else
        {
            self.validerEnAttente.selectedSegmentIndex = 1
        }
        
        
        self.commentaireTextEdit.text = recette.getCommentaireRecette()

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
