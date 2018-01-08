//
//  Compte.swift
//  IF26_project
//
//  Created by Corentin Fievet on 07/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class Compte: NSObject {

    private var id: Int
    private var numero: String
    private var dateAjout: Date
    private var capital: Double
    private var cloture: Bool
    private var idUtilisateur: Int
    
    init(id: Int, numero: String, dateAjout: Date, capital: Double, cloture: Bool, idUtilisateur: Int)
    {
        self.id = id
        self.numero = numero
        self.dateAjout = dateAjout
        self.capital = capital
        self.cloture = cloture
        self.idUtilisateur = idUtilisateur
    }
    
    func getIdCompte() -> Int {
        return self.id;
    }
    func getCaptial() -> Double {
        return self.capital;
    }
    
    func setCapital(cap: Double) -> Void
    {
        self.capital = cap
    }
    
    public override var description: String { return "Numero Compte \(self.numero), Capital \(self.capital)" }
    
    //Fonction permettant d'insérer un nouveau compte
    static func insertNewCompte(numero: String, capital: Double)
    {
       let insertCompte =  Database.compteTable.insert(Database.numeroCompte <- numero, Database.capitalCompte <- capital, Database.dateAjoutCompte <- Date(), Database.clotureCompte <- false, Database.idUserCompte <- ViewController.userConnecte!.getIdUser())        
        
        do
        {
            try Database.databaseDB.run(insertCompte)
        }
        catch
        {
            print(error)
        }
    }
    
    //Fonctin retournant une liste de compte en fonction de son l'id prit en paramètre
    static func getCompteByIdUser(idUser: Int)  -> Array<Compte>
    {
        var arrayCompte = Array<Compte>()
        do
        {
            let query = try Database.databaseDB.prepare(Database.compteTable.filter(Database.idUserCompte == idUser))
            for que in query
            {
                let compte: Compte = Compte(id: que[Database.idCompte], numero: que[Database.numeroCompte], dateAjout: que[Database.dateAjoutCompte], capital: que[Database.capitalCompte], cloture: que[Database.clotureCompte], idUtilisateur: que[Database.idUserCompte])
                arrayCompte.append(compte)
                print(compte)
            }
        }
        catch
        {
            print(error)
        }
        
        return arrayCompte
    }
    
    //Fonction retournant un compte en fonction de son Id prit en paramètre
    static func getCompteById(idCompte: Int)  -> Compte?
    {
        var compte: Compte? = nil
        do
        {
            let query = try Database.databaseDB.prepare(Database.compteTable.filter(Database.idCompte == idCompte))
            for que in query
            {
                compte = Compte(id: que[Database.idCompte], numero: que[Database.numeroCompte], dateAjout: que[Database.dateAjoutCompte], capital: que[Database.capitalCompte], cloture: que[Database.clotureCompte], idUtilisateur: que[Database.idUserCompte])
            }
        }
        catch
        {
            print(error)
        }
        
        return compte
    }
    
    //Fonction permettant de mettre à jour le montant d'un capital
    func updateCapital(montant: Double)
    {
        do
        {
            let newCapital = self.capital + montant
            let compte = Database.compteTable.filter(Database.idCompte == self.id)
            try Database.databaseDB.run(compte.update(Database.capitalCompte <- (newCapital)))
            self.setCapital(cap: newCapital)
        }
        catch
        {
            print(error)
        }
    }
    
    func getCaptitalCompteEnAttent() -> Double
    {
        var recetteArrayList: Array<Recette> = Recette.getRecetteByIdCompteEnAttente(idCompte: self.getIdCompte());
        var montantEnAttente: Double = 0;
        var count: Int = recetteArrayList.count - 1
        if(count < 0)
        {
            count = 0
        }
        if(count > 0)
        {
            for i in 0...count
            {
                montantEnAttente += recetteArrayList[i].getMontantRecette();
            }
        }
        
        return (self.getCaptial() + montantEnAttente)
    }
}
