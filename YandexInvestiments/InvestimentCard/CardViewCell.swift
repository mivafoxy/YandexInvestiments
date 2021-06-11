//
//  CardViewCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 11.06.2021.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    @IBOutlet weak var sectionName: UILabel!
    
    public func setup(sectionName: String) {
        self.sectionName.text = sectionName
        self.sectionName.sizeToFit()
    }

}
