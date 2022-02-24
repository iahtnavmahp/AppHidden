//
//  SQLService.swift
//  lawpro
//
//  Created by devsenior on 06/09/2021.
//

import UIKit
import SQLite
extension FileManager {
    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws -> String
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                .userDomainMask,
                                true).first {
            let fileName = "\(name).\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                                   .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path

            if !self.fileExists(atPath: fullDestPathString) {
                try self.copyItem(atPath: bundlePath, toPath: fullDestPathString)
                
            }
            return fullDestPathString
        }
        return ""
    }
}
class SQLService: NSObject {
    static let shared: SQLService = SQLService()
    var DatabaseRoot:Connection?
    
    var wordListArray = String()
    
    var DataCategory:[ModelCategory] = [ModelCategory]()
    var DataQuiz2:[ModelQuiz2] = [ModelQuiz2]()
    
    func loadInit(linkPath:String){     do {
        let fileManager = FileManager.default
        let dbPath = try fileManager.copyfileToUserDocumentDirectory(forResource: "thaingu123", ofType: "db")
        DatabaseRoot = try Connection ("\(dbPath)")
    }catch{
        DatabaseRoot = nil
        let nserror = error as NSError
        print("Cannot connect to Databace. Error is: \(nserror), \(nserror.userInfo)")
    }

    }
    
    func getDataCategory(closure: @escaping (_ response: [ModelCategory]?, _ error: Error?) -> Void) {
        let users1 = Table("Category")
        let id1 = Expression<String>("id")
        let title1 = Expression<String>("title")
        let descrption1 = Expression<String>("descrption")
        let fav1 = Expression<Int>("fav")
       
        DataCategory.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    DataCategory.append(ModelCategory(id: user[id1],
                                                      title: user[title1],
                                                      descrption: user[descrption1],
                                                      fav: user[fav1]))
                }
            } catch  {}
        }
        closure(DataCategory, nil)
    }
    func getQuiz2(closure: @escaping (_ response: [ModelQuiz2]?, _ error: Error?) -> Void) {
        let users1 = Table("Quiz2")
        let id1 = Expression<Int>("id")
        let question1 = Expression<String>("question")
        let ans1 = Expression<String>("ans")
        let key1 = Expression<Int>("key")
        let firstpass1 = Expression<Int>("firstpass")
   
        DataQuiz2.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    DataQuiz2.append(ModelQuiz2(id: user[id1]
                                                , question: user[question1]
                                                
                                                , ans: user[ans1], key: user[key1], firstpass: user[firstpass1]))
                }
            } catch  {}
        }
        closure(DataQuiz2, nil)
    }
    func addFavoriteDatabase(id:String, favorite:Int) -> Void {
            let users = Table("Category")
            let fav = Expression<Int>("fav")
            let id1 = Expression<String>("id")
        
            if let DatabaseRoot = DatabaseRoot {
                do {
                    let alice = users.filter(id1 == id)
                    try DatabaseRoot.run(alice.update(fav <- favorite))
                } catch{
                    print(error)
                    return
                }
            }
            
        }
    func updateKey(id:Int) -> Void {
            let users = Table("Quiz2")
            let key = Expression<Int>("key")
            let id1 = Expression<Int>("id")
        
            if let DatabaseRoot = DatabaseRoot {
                do {
                    let alice = users.filter(id1 == id)
                    try DatabaseRoot.run(alice.update(key <- 1))
                } catch{
                    print(error)
                    return
                }
            }
            
        }
    func updatePass(id:Int) -> Void {
            let users = Table("Quiz2")
            let firstpass = Expression<Int>("firstpass")
            let id1 = Expression<Int>("id")
        
            if let DatabaseRoot = DatabaseRoot {
                do {
                    let alice = users.filter(id1 == id)
                    try DatabaseRoot.run(alice.update(firstpass <- 1))
                } catch{
                    print(error)
                    return
                }
            }
            
        }
    
   
    
   
}
