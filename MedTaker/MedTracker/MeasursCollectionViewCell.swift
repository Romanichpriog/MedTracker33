//
//  MeasursCollectionViewCell.swift
//  MedTracker
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class MeasursCollectionViewCell: UICollectionViewCell {
    static let reuseId = "MeasursGalleryCollectionViewCell"
    
  
        lazy var name:UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = ""
            label.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return label
            
        }()
        lazy var hidenView:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            view.layer.cornerRadius = 40
            return view
        }()
        lazy var dobavit:UILabel = {
            let label = UILabel()
            label.text = "Добавить"
            label.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return label
            
        }()
        
        lazy var nextData:UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return label
            
        }()
    
    lazy var last:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
        
    }()
        lazy var unit: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return label
            
        }()
        
        

            
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            addSubview(name)
            name.snp.makeConstraints { (make) in
                make.top.equalTo(self).offset(15)
                make.centerX.equalTo(self)
            }
            addSubview(last)
            last.snp.makeConstraints { (make) in
                make.top.equalTo(name.snp.bottom).offset(20)
                make.centerX.equalTo(name)
            }
            addSubview(nextData)
            nextData.snp.makeConstraints { (make) in
                make.top.equalTo(last.snp.bottom).offset(20)
                make.centerX.equalTo(name)
            }
            addSubview(hidenView)
            hidenView.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
                
            }
            hidenView.addSubview(dobavit)
            dobavit.snp.makeConstraints { (make) in
                make.center.equalTo(hidenView)
            }
            


            
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = 40
            self.layer.shadowRadius = 9
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 5, height: 8)
            self.clipsToBounds = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
}
    

