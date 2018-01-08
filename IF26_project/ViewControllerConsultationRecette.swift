//
//  ViewControllerConsultationRecette.swift
//  IF26_project
//
//  Created by Corentin Fievet on 08/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class ViewControllerConsultationRecette: UIViewController {

    @IBOutlet weak var idRecette: UILabel!
    
    @IBOutlet weak var dateRecette: UILabel!
    
    @IBOutlet weak var montantRecette: UILabel!
    
    @IBOutlet weak var commentaireRecette: UILabel!
    
    @IBOutlet weak var retourListeRecettes: UIButton!
    
    @IBAction func retour(_ sender: UIButton) {
        CompteTableViewController.compte = Compte.getCompteById(idCompte: CompteTableViewController.compte!.getIdCompte())
        let vc = storyboard?.instantiateViewController(withIdentifier: "recette") as! RecetteTableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func supprimerBoutton() {
        let recette: Recette = RecetteTableViewController.recette!
        recette.deleteRecette()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "recette") as! RecetteTableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recette: Recette = RecetteTableViewController.recette!
        
        idRecette.text = String(recette.getIdRecette())
        dateRecette.text = "date"
        montantRecette.text = String(recette.getMontantRecette())
        commentaireRecette.text = String(recette.getCommentaireRecette())

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
