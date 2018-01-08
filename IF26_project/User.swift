//
//  User.swift
//  IF26_project
//
//  Created by Corentin Fievet on 06/12/2017.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class User: NSObject {

    private var id: Int
    private var nom: String
    private var nomMarital: String?
    private var prenom: String
    private var email: String
    private var identifiant: String
    private var motDePasse: String
    private var idGenre: Int
    
    init(id: Int, nom: String, nomMarital: String?, prenom: String, email: String, identifiant: String, motDePasse: String, idGenre: Int) {
        self.id = id
        self.nom = nom
        self.nomMarital = nomMarital
        self.prenom = prenom
        self.email = email
        self.identifiant = identifiant
        self.motDePasse = motDePasse
        self.idGenre = idGenre
    }
    
    func getIdUser() -> Int {
        return self.id;
    }
    
    public override var description: String { return "User: idUser \(self.id), Nom \(self.nom), Prenom \(self.prenom)" }
    
    static func insertNewUser(name: String, prenom: String, nomMarital: String?, email: String, identidiant: String, motDePasse: String, idGenre: Int)
    {
        let insertUser = Database.usersTable.insert(Database.nom <- name, Database.prenom <- prenom, Database.nomMarital <- nomMarital, Database.email <- email, Database.identifiant <- identidiant, Database.motDePasse <- motDePasse, Database.idUserGenre <- idGenre)
    
        do
        {
            try Database.databaseDB.run(insertUser)
            print("INSERTED USER")
        }
        catch
        {
            print(error)
        }
    }
    
    static func getUserByEmail(email: String) -> User?
    {
        do
        {
            let query = try Database.databaseDB.prepare(Database.usersTable.filter(Database.email == email))
            for que in query
            {
                let user = User(id: que[Database.idUser], nom: que[Database.nom], nomMarital: que[Database.nomMarital], prenom: que[Database.prenom], email: que[Database.email], identifiant: que[Database.identifiant], motDePasse: que[Database.motDePasse], idGenre: que[Database.idUserGenre])
                print(user)
                return user
                
            }
        }
        catch
        {
            print(error)
        }
        
        return nil
    }
    
    static func getUserByLogin(login: String) -> User?
    {
        do
        {
            let query = try Database.databaseDB.prepare(Database.usersTable.filter(Database.identifiant == login))
            for que in query
            {
                let user = User(id: que[Database.idUser], nom: que[Database.nom], nomMarital: que[Database.nomMarital], prenom: que[Database.prenom], email: que[Database.email], identifiant: que[Database.identifiant], motDePasse: que[Database.motDePasse], idGenre: que[Database.idUserGenre])
                print(user)
                return user
                
            }
        }
        catch
        {
            print(error)
        }
        
        return nil
    }
}
