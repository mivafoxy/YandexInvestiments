//
//  SuggestionCollectionCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 11.06.2021.
//

import UIKit

class SuggestionCollectionCell: UICollectionViewCell {

    @IBOutlet weak var suggestionName: UILabel!
    
    public func setup(suggestionName: String) {
        self.suggestionName.text = suggestionName
        self.suggestionName.sizeToFit()
    }
}
