//
//  EndingCollectionView.swift
//  MedTracker
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class EndingCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    weak var vc: UIViewController?

    var cells = [Pill]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = dequeueReusableCell(withReuseIdentifier: PillsCollectionViewCell.reuseId, for: indexPath) as! PillsCollectionViewCell
            
            
        
            
        cell.hidenView.backgroundColor = UIColor.clear
        cell.dobavit.isHidden = true
        cell.pillName.text = cells[indexPath.item].pillName
        cell.timeTake.text = "Принять в: "+cells[indexPath.item].shedule.components(separatedBy: ",")[0]
        cell.dozaName.text = cells[indexPath.item].doza+" "+cells[indexPath.item].unit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("нажата \(indexPath.item) ячейка")
        vc?.performSegue(withIdentifier: "goToAdd", sender: nil)
        

    }
  



    
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: frame.height * 0.85)
    }
    init(vc: UIViewController){
        self.vc = vc
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 0.971986115, green: 1, blue: 0.8419048786, alpha: 1)
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        
        
        delegate = self
        dataSource = self
        
        
        register(PillsCollectionViewCell.self, forCellWithReuseIdentifier: PillsCollectionViewCell.reuseId)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        
    }
    
    func set (cells: [Pill]){
        self.cells = cells
        self.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
