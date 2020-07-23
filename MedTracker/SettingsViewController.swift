//
//  SettingsViewController.swift
//  MedTracker
//
//  Created by MacBook Air on 18.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import Eureka

class SettingsViewController: FormViewController {

override func viewDidLoad() {
    super.viewDidLoad()
    createForm()
}

func createForm() {
    form +++
        
    Section("Единицы измерения")
    
    <<< PushRow<String>() {
        $0.title = "Вес"
        $0.options = ["Килограммы", "Фунты"]
        $0.value = "Килограммы"
        $0.selectorTitle = "Выберите единицу измерения веса"
        }.onPresent { from, to in
            to.dismissOnSelection = false
            to.dismissOnChange = false
    }
    
    +++
        
    Section("Цель")
        
    <<< DecimalRow("dreamWeightLabel") {
        $0.title = "Желаемый вес"
        $0.value = UserDefaults.standard.value(forKey: "dreamWeight") as? Double
        
    }.onChange({ (row) in
        UserDefaults.standard.set(Double(row.value!), forKey: "dreamWeight")
    })
        
        
    +++
    
    Section("Индекс массы тела")
       
    <<< SwitchRow() {
        $0.title = "Показывать ИМТ"
        $0.value = true
    }
    
    +++
    
    Section("Отсрочка напоминаний")
    
    <<< AlertRow<String>() {
        $0.title = "Время отсрочки напоминаний"
        $0.cancelTitle = "Закрыть"
        $0.selectorTitle = "Время"
        $0.options = ["1 минута", "5 минут", "10 минут", "15 минут", "30 минут"]
        $0.value = "10 минут"
        }.onChange { row in
            print(row.value ?? "No Value")
        }
        .onPresent{ _, to in
            to.view.tintColor = .systemBlue
    }

    
    }

    
}

