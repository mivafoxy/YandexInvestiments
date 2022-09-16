//
//  SuggestionCollectionCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 11.06.2021.
//

import UIKit

class SuggestionCollectionCell: UICollectionViewCell {

    public var suggestionsModel: SuggestionsModel?
    
    @IBOutlet weak var suggestionName: UILabel!
    
    public func setup(suggestionsModel: SuggestionsModel) {
        self.suggestionsModel = suggestionsModel
        self.suggestionName.text = suggestionsModel.name
        self.suggestionName.sizeToFit()
    }
}
