//
//  ATM.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//


import RealmSwift

class Persistence: Object {
    
    func add() {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(self)
            })
        } catch let error as NSError {
            print(error)
        }
    }
    
    func update() {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(self, update: true)
            })
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(self)
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
}

class PersistenceGetter<T: Object> {
    class func first() -> T? {
        do {
            let realm = try Realm()
            let objects = realm.objects(T.self)
            return objects.first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
