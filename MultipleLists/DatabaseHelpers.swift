//
//  DatabaseHelpers.swift
//  MultipleLists
//
//  Created by Swift on 9/27/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit
import SQLite

class DatabaseHelpers{
    
    init?(){
        do{
            try setupDatabase()
        }catch{
            print(error)
            return nil
            }
        
    }
    
    private let table = Table("table")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let email = Expression<String?>("email")
    
    private var db: Connection?
    
    private func createTable() throws {
        do {
            try db!.run(user.create(ifNotExist: true){
                
                t in
                
                t.column(id, primaryKey: .Autoincrement)
                t.column(email, unique: true)
                t.column(name)
                
                })
            
        } catch {
            
            throw error
                
        }
        
    }
    func create(name: String, email: String) throws{
        let insert = user.insert(self.name <- name, self.email <- email)
        
        
        do{
            let rowid = try db!.run(insert)
            print(rowid)
        } catch{
            throw error
        }
        
    }
    
    func read(name: String)throws{
        var result: String?
        
        do{
            for user in try db!.prepare(users.filter(self.name.like("%\(name)%)"))){
                print("\(user[id])")
            }
        }catch{
            
            }
        
        return result
    }
    
    private func setupDatabase() throws {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        do{
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        }catch{
                throw error
            }
        }
    
    
        
    }

