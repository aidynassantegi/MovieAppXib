//
//  CastCollectionViewCell.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 05.06.2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castRoleLabel: UILabel!
    
    private var castImage: UIImage?
    private var castName: String?
    private var castRole: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.layer.cornerRadius = 25
    }
    
    func setup(cast: Cast) {
        castNameLabel.text = cast.name
        castRoleLabel.text = cast.role
        castImageView.kf.setImage(with: URL(string: cast.profilePathUrl ?? ""))
    }

}
