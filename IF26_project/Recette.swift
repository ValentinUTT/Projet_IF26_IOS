//
//  Recette.swift
//  IF26_project
//
//  Created by Corentin Fievet on 07/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class Recette: NSObject {
    
    
    private var id: Int
    private var date: Date
    private var montant: Double
    private var idCompte: Int
    private var commntaire: String
    private var idEtat: Int
    
    init(id: Int, date: Date, montant: Double, idCompte: Int, commentaire: String, etat: Int)
    {
        self.id = id
        self.date = date
        self.montant = montant
        self.idCompte = idCompte
        self.commntaire = commentaire
        self.idEtat = etat
    }
    
    func getIdRecette() -> Int {
        return self.id;
    }
    
    func getDateRecette() -> Date {
        return self.date;
    }
    
    func getMontantRecette() -> Double {
        return self.montant;
    }
    
    func getIdCompte() -> Int {
        return self.idCompte;
    }
    
    func getCommentaireRecette() -> String {
        return self.commntaire;
    }
    
    func getEtatRecette() -> Int {
        return self.idEtat;
    }
    
    public override var description: String { return "Recette: idREcette \(self.id), Montant \(self.montant), Commentaire \(self.commntaire)" }
    
    static func insertNewRecette(commentaire: String, montant: Double, etat: Int)
    {
        let insertRecette = Database.recetteTable.insert(Database.dateRecette <- Date(), Database.montantRecette <- montant, Database.idCompte <- CompteTableViewController.compte!.getIdCompte(), Database.commentaireRecette <- commentaire, Database.idEtatRecette <- etat)
        
        do
        {
            try Database.databaseDB.run(insertRecette)
            print("INSERTED Recette")
        }
        catch
        {
            print(error)
        }
    }
    
    static func getRecetteByIdCompte(idCompte: Int)  -> Array<Recette>
    {
        var arrayRecette = Array<Recette>()
        do
        {
            let query = try Database.databaseDB.prepare(Database.recetteTable.filter(Database.idCompteRecette == idCompte))
            for que in query
            {
                let recette: Recette = Recette(id: que[Database.idRecette], date: que[Database.dateRecette], montant: que[Database.montantRecette], idCompte: que[Database.idCompteRecette], commentaire: que[Database.commentaireRecette], etat: que[Database.idEtatRecette])
                arrayRecette.append(recette)
                print(recette)
            }
        }
        catch
        {
            print(error)
        }
        
        return arrayRecette
    }
    
    static func getRecetteByIdCompteEnAttente(idCompte: Int)  -> Array<Recette>
    {
        var arrayRecette = Array<Recette>()
        do
        {
            let query = try Database.databaseDB.prepare(Database.recetteTable.filter(Database.idCompteRecette == idCompte && Database.idEtatRecette == 1))
            for que in query
            {
                let recette: Recette = Recette(id: que[Database.idRecette], date: que[Database.dateRecette], montant: que[Database.montantRecette], idCompte: que[Database.idCompteRecette], commentaire: que[Database.commentaireRecette], etat: que[Database.idEtatRecette])
                arrayRecette.append(recette)
                print(recette)
            }
        }
        catch
        {
            print(error)
        }
        
        return arrayRecette
    }
    
    func deleteRecette()
    {
        do
        {
            let recette = Database.recetteTable.filter(Database.idRecette == self.id)
            try Database.databaseDB.run(recette.delete())
            
            if(self.getEtatRecette() == 2)
            {
                CompteTableViewController.compte!.updateCapital(montant: -self.montant)
                CompteTableViewController.compte = Compte.getCompteById(idCompte: CompteTableViewController.compte!.getIdCompte())
            }
        }
        catch
        {
            print(error)
        }
    }
    
    //Fonction retournant une recette en fonction de son ID prit en paramètre
    static func getRecetteById(idRecette: Int)  -> Recette?
    {
        var recette: Recette? = nil
        do
        {
            let query = try Database.databaseDB.prepare(Database.recetteTable.filter(Database.idRecette == idRecette))
            for que in query
            {
                recette = Recette(id: que[Database.idRecette], date: que[Database.dateRecette], montant: que[Database.montantRecette], idCompte: que[Database.idCompteRecette], commentaire: que[Database.commentaireRecette], etat: que[Database.idEtatRecette])
            }
        }
        catch
        {
            print(error)
        }
        
        return recette
    }
    
    func updateRecette(montant: Double, commentaire: String, idEtat: Int)
    {
        do
        {
            //CompteTableViewController.compte!.updateCapital(montant: -self.montant)
            let recette = Database.recetteTable.filter(Database.idRecette == self.id)
            try Database.databaseDB.run(recette.update(Database.montantRecette <- montant, Database.commentaireRecette <- commentaire, Database.idEtatRecette <- idEtat))
            
            if(idEtat != self.getEtatRecette())
            {
                if(idEtat == 1)
                {
                    CompteTableViewController.compte!.updateCapital(montant: -(montant))
                }
                else
                {
                    CompteTableViewController.compte!.updateCapital(montant: (montant))
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
}
