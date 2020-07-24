//
//  HelpersViewController.swift
//  MedTracker
//
//  Created by MacBook Air on 18.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import Eureka
import Charts
import ViewRow
import SwiftChart
import HealthKit



class HelpersViewController: FormViewController, ChartViewDelegate {

override func viewDidLoad() {
    super.viewDidLoad()
    createForm()
    self.navigationItem.title = "Помощники"
}
    
    
    func createForm() {
    TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12)
        }

        form = Section("Выберите помощника")
            <<< SegmentedRow<String>("segments"){
                $0.options = ["Калькулятор", "Планировщик", "Дневник веса"]
                $0.value = "Калькулятор"
            }
            +++ Section("Калькулятор"){
                $0.tag = "calc_s"
                $0.hidden = "$segments != 'Калькулятор'" // .Predicate(NSPredicate(format: "$segments != 'Калькулятор'"))
            }
            
            <<< IntRow() {
                $0.title = "Ваш вес"
                $0.value = UserDefaults.standard.value(forKey: "weight") as? Int
            }
            
            <<< IntRow() {
                $0.title = "Ваш возраст"
                $0.value = (UserDefaults.standard.value(forKey: "age") as? Int)
            }
            
            <<< PushRow<String>("pills") {
                $0.title = "Лекарство"
                $0.options = ["Нурофен", "Аскорбиновая кислота", "Ксарелто", "Детралекс", "Кагоцел", "Конкор", "Кардиомагнил", "Мексидол", "Цитрамон", "Уголь активированный", "Парацетамол", "Эналаприл"]//Список лекарств юзера
                $0.selectorTitle = "Выберите лекарство!"
                }.onPresent { from, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
            }.onChange({ (row) in
                if let r = self.form.rowBy(tag: "labelPills") as? LabelRow {
                    if row.value == "Нурофен" {
                        r.value = "2 таблетки 3 раза в сутки"
                    }else if row.value == "Аскорбиновая кислота" {
                        r.value = "1-2 драже 3-5 раз в день"
                    }else if row.value == "Ксарелто" {
                        r.value = "1 таблетка 2 раза в сутки"
                    }else if row.value == "Детралекс" {
                        r.value = "1 таблетка 1 раз в сутки"
                    }else if row.value == "Кагоцел" {
                        r.value = "2 таблетки 3 раза в сутки"
                    }else if row.value == "Конкор" {
                        r.value = "1 таблетка 1 раз в сутки"
                    }else if row.value == "Кардиомагнил" {
                        r.value = "1 таблетка 1 раз в сутки"
                    }else if row.value == "Мексидол" {
                        r.value = "2 таблетка 3 раза в сутки"
                    }else if row.value == "Цитрамон" {
                        r.value = "1 таблетка каждые 4 часа"
                    }else if row.value == "Уголь активированный" {
                        r.value = "6 таблеток единоразово"
                    }else if row.value == "Эналаприл" {
                        r.value = "1 таблетка 3 раза в сутки"
                    }else if row.value == "Парацетамол" {
                        r.value = "2 таблетки 3 раза в сутки"
                    }
                }
            })
            
            <<< LabelRow("labelPills") { row in
                row.hidden = .function(["pills"], { form -> Bool in
                    let row : PushRow = form.rowBy(tag: "pills") as! PushRow<String>
                    if row.value == nil {
                        return true
                    } else {
                        return false
                    }
                    
                })
            }

            +++ Section("Планировщик"){
                $0.tag = "plan_s"
                $0.hidden = "$segments != 'Планировщик'"
            }
             <<< DateRow("dateFrom") { $0.value = Date(); $0.title = "С" }
            
            <<< DateRow("dateTo") {
                $0.title = "По"
                
            }
            

            <<< TextAreaRow ("label") {
                $0.value = "Нурофен - 42 таблетки\rАскорбиновая кислота - 70 таблеток\rКсарелто - 14 таблеток\rДетралекс - 7 таблеток\rКагоцел - 42 таблетки\rКонкор - 7 таблеток\rКардиомагнил - 7 таблеток\rМексидол - 42 таблетки\rЦитрамон - 21 таблетка\rУголь активированный - 24 таблетки\rПарацетамол 42 таблетки\rЭналаприл - 21 таблетка"
                $0.hidden = .function(["dateTo"], { form -> Bool in
                    let row : DateRow = form.rowBy(tag: "dateTo") as! DateRow
                    if row.value == nil {
                        return true
                    } else {
                        return false
                    }
                    
                })
                $0.textAreaMode = .readOnly
                $0.textAreaHeight = .fixed(cellHeight: 300)
            }


            +++ Section("Дневник веса"){
                $0.tag = "weight_s"
                $0.hidden = "$segments != 'Дневник веса'"
            }
            <<< DecimalRow() {
                $0.title = "Текущий вес"
                $0.value = UserDefaults.standard.value(forKey: "weight") as? Double
            }

                       <<< ViewRow<Chart>("graph") { (row) in
                           row.title = "График изменения веса"
                       }
                       .cellSetup { (cell, row) in
                           cell.view = Chart(frame: CGRect(x: 0, y: 0, width: 100, height: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 210))
                           
                           cell.viewLeftMargin = 5.0
                           cell.viewRightMargin = 5.0
                           
                           let sampleCount = data.count
                           let msPerSample = 3.90625
                           let intervalSamples = 200.0 /* ms */ / Double(msPerSample)
                           let baseLine = 51
                          
                          let series = ChartSeries(data.compactMap({ (v) in return Double(v) }))
                           let min = floor(data.min()!)
                           let max = ceil(data.max()!)
                           
                           var xLabelValues : [Double] = []
                           
                           for i in 0...Int(Double(sampleCount) / intervalSamples) {
                               xLabelValues.append(Double(Int(Double(i) * intervalSamples)))
                           }
                           
                        
                        
                           cell.view!.xLabels = xLabelValues
                        cell.view!.xLabelsFormatter = { (labelIndex, labelValue) -> String in
                            String("-500г")
                        }
                           cell.view!.yLabels = [min, max]
                           cell.view!.yLabelsFormatter = { return "\(Int($1))кг" }
                           
                           series.area = true
                        
                        series.colors = (
                          above: ChartColors.redColor(),
                          below: ChartColors.cyanColor(),
                          zeroLevel:UserDefaults.standard.value(forKey: "dreamWeight") as! Double
                        )
                           cell.view!.add(series)
                       }
    }
}

let data = [62,
            61,
            61,
            60,
            60.5,
            59,
            60,
            60.5,
            60.5,
            60.5,
            61,
            60.5,
            60,
            59.5,
            59
]

