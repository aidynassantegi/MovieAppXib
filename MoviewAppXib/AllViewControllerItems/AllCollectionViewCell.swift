//
//  AllCollectionViewCell.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 03.06.2022.
//

import UIKit

class AllCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ganreLabel: UILabel!
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemYellow.cgColor
        
        heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
    }
}
