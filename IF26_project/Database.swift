//
//  Database.swift
//  IF26_project
//
//  Created by Corentin Fievet on 06/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class Database: NSObject {

    static var databaseDB: Connection!
    
    static let genreTable = Table("Genre")
    static let idGenre = Expression<Int>("idGenre")
    static let libelleGenre = Expression<String>("LibelleGenre")
    
    static let usersTable = Table("users")
    static let idUser = Expression<Int>("idUser")
    static let nom = Expression<String>("nom")
    static let nomMarital = Expression<String?>("nomMarital")
    static let prenom = Expression<String>("prenom")
    static let email = Expression<String>("email")
    static let identifiant = Expression<String>("identifiant")
    static let motDePasse = Expression<String>("motDePasse")
    static let idUserGenre = Expression<Int>("idGenre")
    
    static let compteTable = Table("compte")
    static let idCompte = Expression<Int>("idCompte")
    static let numeroCompte = Expression<String>("numero")
    static let dateAjoutCompte = Expression<Date>("dateAjout")
    static let capitalCompte = Expression<Double>("capital")
    static let clotureCompte = Expression<Bool>("cloture")
    static let idUserCompte = Expression<Int>("idUser")
    
    static let recetteTable = Table("recette")
    static let idRecette = Expression<Int>("idRecette")
    static let dateRecette = Expression<Date>("date")
    static let montantRecette = Expression<Double>("montant")
    static let idCompteRecette = Expression<Int>("idCompte")
    static let commentaireRecette = Expression<String>("commentaire")
    static let idEtatRecette = Expression<Int>("idEtat")
    
    static let etatRecetteTable = Table("etatRecette")
    static let idEtat = Expression<Int>("idEtat")
    static let libelleEtat = Expression<String>("libelle")
    
    static func createDatabase()
    {
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            Database.databaseDB = database
            
            createTableGenre()
            createEtatRecetteTable()
            createTableUser()
            createTableCompte()
            createTableRecette()
        }
        catch
        {
            print(error)
        }
    }
    
    static func createTableGenre()
    {
        let createTableUser = Database.genreTable.create(ifNotExists: false) { (table) in
            table.column(Database.idGenre, primaryKey: true)
            table.column(Database.libelleGenre)
        }
        
        do
        {
            //try Database.databaseDB.run(usersTable.drop())
            try Database.databaseDB.run(createTableUser)
            //print("Created Table User")
        }
        catch
        {
            print(error)
        }
        
        insertDefaultDataGenre(libelle: "Monsieur")
        insertDefaultDataGenre(libelle: "Madame")
    }
    
    static func createTableUser()
    {
        let createTableUser = Database.usersTable.create(ifNotExists: false) { (table) in
            table.column(Database.idUser, primaryKey: true)
            table.column(Database.nom)
            table.column(Database.nomMarital)
            table.column(Database.prenom)
            table.column(Database.identifiant, unique: true)
            table.column(Database.email, unique: true)
            table.column(Database.motDePasse)
            table.column(Database.idUserGenre)
            table.foreignKey(idUserGenre, references: genreTable, idGenre)
        }
        
        do
        {
            //try Database.databaseDB.run(usersTable.drop())
            try Database.databaseDB.run(createTableUser)
            //print("Created Table User")
        }
        catch
        {
            print(error)
        }
    }
    
    static func createTableCompte()
    {
        let createTableCompte = Database.compteTable.create(ifNotExists: false) { (table) in
            table.column(Database.idCompte, primaryKey: true)
            table.column(Database.numeroCompte)
            table.column(Database.dateAjoutCompte)
            table.column(Database.capitalCompte)
            table.column(Database.clotureCompte)
            table.column(Database.idUserCompte)
            table.foreignKey(idUserCompte, references: usersTable, idUser)
        }
        
        do
        {
            //try Database.databaseDB.run(compteTable.drop())
            try Database.databaseDB.run(createTableCompte)
            // print("Created Table Compte")
        }
        catch
        {
            print(error)
        }
    }
    
    static func createTableRecette()
    {
        let createTableRecette = Database.recetteTable.create(ifNotExists: false) { (table) in
            table.column(Database.idRecette, primaryKey: true)
            table.column(Database.dateRecette)
            table.column(Database.montantRecette)
            table.column(Database.idCompteRecette)
            table.column(Database.commentaireRecette)
            table.column(Database.idEtatRecette)
            table.foreignKey(idCompteRecette, references: compteTable, idCompte)
            table.foreignKey(idEtatRecette, references: etatRecetteTable, idEtat)
        }
        
        do
        {
            //try Database.databaseDB.run(recetteTable.drop())
            try Database.databaseDB.run(createTableRecette)
            print("Created Table Recette")
        }
        catch
        {
            print(error)
        }
    }
    
    static func createEtatRecetteTable()
    {
        let createTableEtatRecette = Database.etatRecetteTable.create(ifNotExists: false) { (table) in
            table.column(Database.idEtat, primaryKey: true)
            table.column(Database.libelleEtat, unique: true)
        }
        
        do
        {
            //try Database.databaseDB.run(etatRecetteTable.drop())
            try Database.databaseDB.run(createTableEtatRecette)
            print("Created Table Etat Recette")
            
        }
        catch
        {
            print(error)
        }
        
        insertDefaultDataEtatRecette(libelle: "En Attente")
        insertDefaultDataEtatRecette(libelle: "Valider")
        
    }
    
    static func insertDefaultDataEtatRecette(libelle: String)
    {
        let insertDefaultData = Database.etatRecetteTable.insert(Database.libelleEtat <- libelle)
        
        do
        {
            try Database.databaseDB.run(insertDefaultData)
            print("INSERTED etat")
        }
        catch
        {
            print(error)
        }
        
    }
    
    static func insertDefaultDataGenre(libelle: String)
    {
        let insertDefaultData = Database.genreTable.insert(Database.libelleGenre <- libelle)
        
        do
        {
            try Database.databaseDB.run(insertDefaultData)
            print("INSERTED genre")
        }
        catch
        {
            print(error)
        }
    }
}
