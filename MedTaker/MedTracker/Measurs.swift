//
//  Measurs.swift
//  MedTracker
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation

final class Measurs:Decodable {
    var id: String
    var name: String
    var nextDate: String
    var unit: String
    var last : String


    init(id: String, name:String, nextDate: String, unit: String,last:String) {
        self.last = last
        self.id = id
        self.name = name
        self.nextDate = nextDate
        self.unit = unit
    }
    
}
