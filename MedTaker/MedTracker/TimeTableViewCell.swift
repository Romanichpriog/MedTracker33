//
//  TimeTableViewCell.swift
//  MedTracker
//
//  Created by Roman on 23.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SnapKit
class TimeTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width, height: 110))
        view.backgroundColor = .green
        return view
        
    }()
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
    }
}


