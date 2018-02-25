//
//  RealmService.swift
//  ImageGallery
//
//  Created by DavidTran on 2/24/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    private init(){}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object >(_ object: T){
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func update<T:Object>(_ object: T, dict:[String:Any]){
        do {
            try realm.write {
                for (key,value) in dict{
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    func delete<T:Object>(_ object:T){
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}
