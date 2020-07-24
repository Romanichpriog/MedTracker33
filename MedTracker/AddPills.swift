//
//  AddPills.swift
//  MedTracker
//
//  Created by Roman on 21.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SnapKit
import Eureka
import FSCalendar
class AddPills:  UIViewController ,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    
    var vc: UIViewController?
    //MARK: -Propirties
    private var selectedVew: UIView!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    private var gest: UITapGestureRecognizer?
    private var imagesNames = ["",""]
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 1.4)
    
    

    //MARK: -UiViews
    lazy var scrView: UIScrollView = {
        let scrol = UIScrollView(frame: .zero)
        scrol.backgroundColor = .white
        scrol.frame = self.view.bounds
        scrol.contentSize = contentViewSize
        return scrol
    }()
    
    lazy var pilImage: UIImageView = {
        let iv = UIImageView()
        iv.tag = 0
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        iv.image = #imageLiteral(resourceName: "DefaultProfileImage").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var pacImage: UIImageView = {
        let iv = UIImageView()
        iv.tag = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        iv.image = #imageLiteral(resourceName: "DefaultProfileImage").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    lazy var vremia:UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        text.sizeToFit()
        text.placeholder = "введите время в формате --:-- через ,"
        return text
        
    }()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        return button
    }()
    
    lazy var buttonText: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "Добавить"
        return label
        
    }()
    
    
    
    

    


    
    lazy var nameTE:UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        text.sizeToFit()
        text.placeholder = "Введите название"
        return text
    }()
    
    lazy var dozaTE:UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        text.sizeToFit()
        text.placeholder = "Введите дозу"
        return text
    }()
    
    lazy var unitTE:UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        text.sizeToFit()
        text.placeholder = "Введите еденицу измерения"
        return text
    }()
    
    lazy var imageStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 60
        view.distribution = .fill
        view.alignment = .fill
        return view
        
    }()
    
    lazy var periudLabel: UILabel = {
        let view = UILabel()
        view.text  = "Период приема"
        view.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
        view.sizeToFit()
        view.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.textAlignment = .center
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.text  = "время приема"
        view.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
        view.sizeToFit()
        view.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.textAlignment = .center
        return view
    }()
    
    
    
    @objc fileprivate func chooseImage(_ gesture: UITapGestureRecognizer) {
        print("Tapped button")
        gest = gesture
        showChooseSourceTypeAlertController()
    }
    
    
    

    

    

    

    

   
    //MARK: -ViewDidiLoad
    override func viewDidLoad() {

        super.viewDidLoad()
        vc = self
        view.addSubview(scrView)
        scrView.addSubview(containerView)
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = false
        containerView.addSubview(calendar)
        containerView.backgroundColor = #colorLiteral(red: 0.971986115, green: 1, blue: 0.8419048786, alpha: 1)
        scrView.backgroundColor = #colorLiteral(red: 0.971986115, green: 1, blue: 0.8419048786, alpha: 1)
            
        self.calendar = calendar
        calendar.allowsMultipleSelection = true
        containerView.addSubview(nameTE)
        containerView.addSubview(imageStack)
        addButton.addSubview(buttonText)
        containerView.addSubview(dozaTE)
        containerView.addSubview(unitTE)
        
        containerView.addSubview(periudLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(vremia)
        containerView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(300)
            make.centerX.equalTo(containerView)
            make.top.equalTo(unitTE.snp.bottom).offset(20)
        }
        vremia.snp.makeConstraints { (make) in
            make.right.left.equalTo(containerView).offset(20)
            make.top.equalTo(timeLabel.snp.bottom).offset(40)
        }
        
        dozaTE.snp.makeConstraints { (make) in
            make.left.right.equalTo(containerView).offset(20)
            make.top.equalTo(vremia.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        unitTE.snp.makeConstraints { (make) in
            make.left.right.equalTo(containerView).offset(20)
            make.top.equalTo(dozaTE.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        buttonText.snp.makeConstraints { (make) in
            make.center.equalTo(addButton)
            make.width.equalTo(120)
        }

        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        calendar.snp.makeConstraints { (make) in
            make.height.equalTo(view.snp.height).dividedBy(3)
            make.left.right.equalTo(view)
            make.top.equalTo(periudLabel.snp.bottom).offset(20)
        }
        imageStack.addArrangedSubview(pilImage)
        imageStack.addArrangedSubview(pacImage)

        pacImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
        }
        pilImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
        }
        imageStack.snp.makeConstraints { (make) in
            make.top.equalTo(nameTE.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(100)
        }
        nameTE.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(35)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(40)
            
        }
        periudLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageStack.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        

        

        
        
        

        



    }
    @objc fileprivate func goBack(){
        DBManageInl.shared.write(object: Pill(id: UUID().uuidString, pillName: nameTE.text!, startDate: firstDate!, duration: lastDate!, doza: dozaTE.text!, unit: unitTE.text!, shedule: vremia.text!, pillImage: imagesNames[0], pakageImage: imagesNames[1]))
        vc?.performSegue(withIdentifier: "goBack", sender: nil)
    }
    
    
    //MARK: -KalendarSettings
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]


            print("datesRange contains: \(datesRange!)")



            return
        }
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                return
            }
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            datesRange = range
            print("datesRange contains: \(datesRange!)")
            return
        }
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
    //MARK: -ExtensiontoimagePicker
extension AddPills: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        selectedVew = gest?.view
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let finImage = editedImage.withRenderingMode(.alwaysOriginal)
            (selectedVew as! UIImageView).image = finImage
            let imageName = UUID().uuidString
            let imagepath = getDocumentary().appendingPathComponent(imageName)
            if let jpeg = finImage.jpegData(compressionQuality: 0.8){
                try? jpeg.write(to: imagepath)
            }
            imagesNames[selectedVew.tag] = imageName
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let finImage = originalImage.withRenderingMode(.alwaysOriginal)
            (selectedVew as! UIImageView).image = finImage
            let imageName = UUID().uuidString
            let imagepath = getDocumentary().appendingPathComponent(imageName)
            if let jpeg = finImage.jpegData(compressionQuality: 0.8){
                try? jpeg.write(to: imagepath)
            }
            imagesNames[selectedVew.tag] = imageName
            
            
            
        }
        print(imagesNames)
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentary() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

}






