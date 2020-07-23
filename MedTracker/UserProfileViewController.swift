//
//  UserProfileViewController.swift
//  MedTracker
//
//  Created by MacBook Air on 16.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import Eureka
import HealthKit

class UserProfileViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndDisplayAgeSexAndBloodType()
        loadAndDisplayMostRecentHeight()
        loadAndDisplayMostRecentWeight()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.createForm()
        }
        self.navigationItem.title = "Профиль"
    }
    
   
    private enum ProfileDataError: Error {
      
      case missingBodyMassIndex
      
      var localizedDescription: String {
        switch self {
        case .missingBodyMassIndex:
          return "Unable to calculate body mass index with available profile data."
        }
      }
    }
    
    class UserHealthProfile {
          
          var age: Int?
          var biologicalSex: HKBiologicalSex?
          var bloodType: HKBloodType?
          var heightInMeters: Double?
          var weightInKilograms: Double?
          
          var bodyMassIndex: Double? {
            
            guard let weightInKilograms = weightInKilograms,
              let heightInMeters = heightInMeters,
              heightInMeters > 0 else {
                return nil
            }
            
            return (weightInKilograms/(heightInMeters*heightInMeters))
          }
        }

    
        private func displayAlert(for error: Error) {
          
          let alert = UIAlertController(title: nil,
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
          
          alert.addAction(UIAlertAction(title: "O.K.",
                                        style: .default,
                                        handler: nil))
          
          present(alert, animated: true, completion: nil)
        }
    
        private let userHealthProfile = UserHealthProfile()
        var labelFormAge: Int?
        var biologicalSexLabel: String?
        var bloodTypeLabel: String?
        var weightLabel: Int?
        var heightLabel: Double?
        var bodyMassIndexLabel: Double?
        
    
        func loadAndDisplayAgeSexAndBloodType() {
            do {
              let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
              userHealthProfile.age = userAgeSexAndBloodType.age
              userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
              userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
              updateLabels()
            } catch let error {
              self.displayAlert(for: error)
            }
        }
    
         func updateLabels() {
                if let age = userHealthProfile.age {
                    self.labelFormAge = age
                }
            
            
            if let biologicalSex = userHealthProfile.biologicalSex {
              self.biologicalSexLabel =  biologicalSex.stringRepresentation
            }

            if let bloodType = userHealthProfile.bloodType {
              self.bloodTypeLabel =  bloodType.stringRepresentation
            }
            
            if let weight = userHealthProfile.weightInKilograms {
              let weightFormatter = MassFormatter()
              weightFormatter.isForPersonMassUse = true
              self.weightLabel = Int(weight)
                UserDefaults.standard.set(self.weightLabel, forKey: "weight")
            }
                
            if let height = userHealthProfile.heightInMeters {
              let heightFormatter = LengthFormatter()
              heightFormatter.isForPersonHeightUse = true
              self.heightLabel = Double(height)
            }
               
            if let bodyMassIndex = userHealthProfile.bodyMassIndex {
              self.bodyMassIndexLabel = Double(String(format: "%.02f", bodyMassIndex))
            }
            
           
        }
    
    func loadAndDisplayMostRecentHeight() {
        //1. Используйте HealthKit для создания типа сэмпла высоты
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
          print("Height Sample Type is no longer available in HealthKit")
          return
        }
            
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
          guard let sample = sample else {
            if let error = error {
              self.displayAlert(for: error)
            }
            return
          }
              
           //2. Преобразуйте сэмпл высоты в метры, сохраните модель профиля,
          // и обновите пользовательский интерфейс.
          let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
          self.userHealthProfile.heightInMeters = heightInMeters
          self.updateLabels()
        }
    }
    
    func loadAndDisplayMostRecentWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("Body Mass Sample Type is no longer available in HealthKit")
          return
        }
            
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
          guard let sample = sample else {
            if let error = error {
              self.displayAlert(for: error)
            }
            return
          }
              
          let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.weightLabel = Int(weightInKilograms)
          self.userHealthProfile.weightInKilograms = weightInKilograms
          self.updateLabels()
        }
    }
    
    func saveBodyMassIndexToHealthKit() {
        guard let bodyMassIndex = userHealthProfile.bodyMassIndex else {
          displayAlert(for: ProfileDataError.missingBodyMassIndex)
          return
        }
        ProfileDataStore.saveBodyMassIndexSample(bodyMassIndex: bodyMassIndex, date: Date())
    }
    
    
    func createForm() {
        form +++ Section("Данные профиля")
                  <<< TextRow() {
                      $0.title = "Имя"
                      $0.value = "Дарья"
                  }

                  <<< TextRow() {
                      $0.title = "Ник"
                      $0.value = "daryamih02"
                  }

                  <<< EmailRow() {
                      $0.title = "Email Address"
                      $0.value = "dm@gmail.com"
                  }

                  <<< PasswordRow() {
                      $0.title = "Пароль"
                      $0.value = "johndoe9876"
                    }
        
                    <<< TextRow() {
                        $0.title = "Группа крови"
                        $0.value = bloodTypeLabel
                        }
            
                <<< IntRow("Weight") {
                    $0.title = "Вес"
                    $0.value = weightLabel
                }
            
                <<< DecimalRow {
                    $0.title = "ИМТ"
                    $0.value = bodyMassIndexLabel//Double(Double(weightLabel!) / (heightLabel! * heightLabel!))
                }
                
                <<< IntRow("age") {
                    $0.title = "Возраст"
                    $0.value = labelFormAge
                    UserDefaults.standard.set(Double($0.value!), forKey: "age")
                }
            
                <<< DecimalRow {
                    $0.title = "Рост"
                    $0.value = heightLabel
                }
            
               <<< PickerInputRow<String>("biologicalSex"){
                   $0.title = "Пол"
                   $0.options = ["Женщина", "Мужчина"]
                   $0.value = biologicalSexLabel
               }
            
            <<< ButtonRow("Настройки") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "SettingsViewController", onDismiss:{  vc in vc.dismiss(animated: true) })
            }
        
            +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Заболевания") {
                                $0.tag = "textfields"
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Добавить новое значение"
                                        }.cellUpdate { cell, row in
                                            cell.textLabel?.textAlignment = .left
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return NameRow() {
                                        $0.placeholder = "Опишите заболевание"
                                    }
                                }
                                $0 <<< TextRow() {
                                    $0.placeholder = "Опишите заболевание"
                                }
                }

        +++ Section()
                    <<< ButtonRow() { (row: ButtonRow) -> Void in
                       row.title = "Сохранить текущие данные в HealthKit"
                        
                       //view.tintColor = .systemRed
                    }
                    .onCellSelection { [weak self] (cell, row) in
                        self?.showAlert()
                    }.cellSetup({ (cell, row) in
                        cell.tintColor = .systemRed
                    })

        }


        @IBAction func showAlert() {
            saveBodyMassIndexToHealthKit()
        }
}
    

extension HKBiologicalSex {
       
       var stringRepresentation: String {
           switch self {
           case .notSet: return "Неизвестный"
           case .female: return "Женщина"
           case .male: return "Мужчина"
           case .other: return "Другое"
           }
       }
   }
   
extension HKBloodType {
     
     var stringRepresentation: String {
       switch self {
       case .notSet: return "Unknown"
       case .aPositive: return "A+"
       case .aNegative: return "A-"
       case .bPositive: return "B+"
       case .bNegative: return "B-"
       case .abPositive: return "AB+"
       case .abNegative: return "AB-"
       case .oPositive: return "O+"
       case .oNegative: return "O-"
       }
     }
   }

