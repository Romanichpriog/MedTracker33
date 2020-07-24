//
//  PillModel.swift
//  MedTracker
//
//  Created by Roman on 21.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import RealmSwift
@objcMembers
final class PillModel: Object{
    dynamic var id = String()
    dynamic var pillName = String()
    dynamic var startDate = Date()
    dynamic var duration = Date()
    dynamic var doza = String()
    dynamic var unit = String()
    dynamic var shedule = String()

    dynamic var pillImage=""
    dynamic var pakageImage=""
    override class func primaryKey() -> String? {
        return "id"
    }
        
}

extension Pill: DBManage{
    typealias RealmObjectType = PillModel
    
    convenience init(realmObject: PillModel) {
        self.init(id: realmObject.id,
                  pillName: realmObject.pillName,
                  startDate: realmObject.startDate,
                  duration: realmObject.duration,
                  doza: realmObject.doza,
                  unit: realmObject.unit,
                  shedule: realmObject.shedule,
                  pillImage: realmObject.pillImage,
                  pakageImage: realmObject.pakageImage)
    }
    
    var realmObject: PillModel {
        PillModel(plainObject: self)
    }
}

extension PillModel{
    convenience init(plainObject: Pill){
        self.init()
        self.id = plainObject.id
        self.pillName = plainObject.pillName
        self.startDate = plainObject.startDate
        self.duration = plainObject.duration
        self.doza = plainObject.doza
        self.unit = plainObject.unit
        self.shedule = plainObject.shedule
        self.pillImage = plainObject.pillImage
        self.pakageImage = plainObject.pakageImage
        
    }
}
