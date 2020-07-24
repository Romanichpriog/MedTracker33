//
//  Pill.swift
//  MedTracker
//
//  Created by Roman on 21.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation


final class Pill:Decodable {
    var id: String
    var pillName: String
    var startDate: Date
    var duration: Date
    var doza: String
    var unit: String
    var shedule: String

    var pillImage:String
    var pakageImage:String
    
    init(id: String,pillName: String,startDate: Date,  duration: Date,  doza:String, unit: String, shedule: String, pillImage: String, pakageImage :String) {
        self.id = id
        self.pillName = pillName
        self.startDate = startDate
        self.duration = duration
        self.doza = doza
        self.unit = unit
        self.shedule = shedule
        self.pillImage = pillImage
        self.pakageImage = pakageImage
    }
    
}


