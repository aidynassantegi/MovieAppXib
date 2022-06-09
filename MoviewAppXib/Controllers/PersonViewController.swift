//
//  PersonViewController.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 06.06.2022.
//

import UIKit


class PersonViewController: UIViewController {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var bibliographyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func setup(personId: Int) {
        NetworkManagerAF.shared.loadPeople(personId: personId) { [weak self] person in
            self?.nameLabel.text = person.name
            self?.title = person.name
            self?.birthdayLabel.text = person.birthday
            self?.bibliographyLabel.text = person.biography
            self?.departmentLabel.text = person.department
            self?.placeOfBirthLabel.text = person.placeOfBirth
            self?.personImageView.kf.setImage(with: URL(string: person.profilePathUrl ?? ""))
        }
    }

}
