//
//  DBManager.swift
//  MedTracker
//
//  Created by Roman on 21.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import RealmSwift
protocol DBManage {
    associatedtype RealmObjectType: Object
    init(realmObject: RealmObjectType)
    var realmObject: RealmObjectType{ get }
}

final class DBManageInl {
    private let currentShemeVersion: UInt64 = 0
    private lazy var  config = Realm.Configuration(
        schemaVersion: currentShemeVersion,
        migrationBlock: { _ ,_ in
            //
        },
        deleteRealmIfMigrationNeeded: true)
    static let shared = DBManageInl()
    private init(){}
    
    
    func write<T: DBManage>(objects: [T]){
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do{
            let realm = try! Realm(configuration: config)
            try! realm.write {
                for object in objects{
                    realm.add(object.realmObject, update: .all)
                }
                
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    
    func write<T: DBManage>(object: T) {
        write(objects: [object])
    }
    
    
    func read<T: DBManage>(type: T.Type, predicate: NSPredicate? = nil) -> [T]{
        do{
            let realm = try! Realm(configuration: config)
            var results = realm.objects(T.RealmObjectType.self)
            if let predicate = predicate{
                results = results.filter(predicate)
            }
            return Array(results.map{T(realmObject: $0)})
        } catch {
            assertionFailure(error.localizedDescription)
            return[]
        }
    }
    
    
    func delete<T: DBManage>(type: T.Type, predicate: NSPredicate){
        do {
            let realm = try! Realm(configuration: config)
            let objects = realm.objects(T.RealmObjectType.self)
            guard let stoppingObject = objects.first else { return }
            
            try realm.write {
                realm.delete(stoppingObject)
            }
        } catch{
            assertionFailure(error.localizedDescription)
        }
    }
    
    
    
    
}
