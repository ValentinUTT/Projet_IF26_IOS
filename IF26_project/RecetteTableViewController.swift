//
//  RecetteTableViewController.swift
//  IF26_project
//
//  Created by Corentin Fievet on 07/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class RecetteTableViewController: UITableViewController {

    @IBOutlet weak var labelCompte: UILabel!
    
    var recettes: [Recette] = []
    var identifiantRecette = "celluleRecette"
    
    public static var recette: Recette?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recettes = Recette.getRecetteByIdCompte(idCompte: CompteTableViewController.compte!.getIdCompte())
        
        let c:String
        if(CompteTableViewController.compte!.getCaptial() != CompteTableViewController.compte!.getCaptitalCompteEnAttent())
        {
            c = CompteTableViewController.compte!.description + "\nMontant en attente : \(CompteTableViewController.compte!.getCaptitalCompteEnAttent())"
        }
        else
        {
            c = CompteTableViewController.compte!.description
        }
        self.labelCompte.text = c
        self.labelCompte.numberOfLines = 2
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recettes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiantRecette, for: indexPath)
        cell.textLabel?.text = "\(recettes[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath.row)")
        let recetteSelect: Recette = recettes[indexPath.row]
        RecetteTableViewController.recette = recetteSelect
        //RecetteTableViewController()
        //self.present(recetteTableView, animated: true, completion: nil)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
