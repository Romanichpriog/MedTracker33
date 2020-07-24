//
//  PillsCollectionViewCell.swift
//  MedTracker
//
//  Created by Roman on 18.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SnapKit
class PillsCollectionViewCell: UICollectionViewCell {
    
    
    static let reuseId = "GalleryCollectionViewCell"
    lazy var pillImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        return image
    }()
    lazy var pillName:UILabel = {
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
    
    lazy var dozaName:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
        
    }()
    lazy var timeTake: UILabel = {
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
        addSubview(pillImage)
        pillImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(20)
        }
        addSubview(pillName)
        pillName.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.centerX.equalTo(self)
        }
        addSubview(timeTake)
        timeTake.snp.makeConstraints { (make) in
            make.top.equalTo(pillName.snp.bottom).offset(20)
            make.centerX.equalTo(pillName)
        }
        addSubview(dozaName)
        dozaName.snp.makeConstraints { (make) in
            make.top.equalTo(timeTake.snp.bottom).offset(20)
            make.centerX.equalTo(pillName)
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

