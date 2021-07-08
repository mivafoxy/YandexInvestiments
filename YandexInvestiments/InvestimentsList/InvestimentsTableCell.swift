//
//  InvestimentsTableCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 09.06.2021.
//

import UIKit

class InvestimentsTableCell: UITableViewCell {

    @IBOutlet weak var companyIcon: UIImageView!
    @IBOutlet weak var investimentName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var favouriteIcon: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    
    public var model: InvestimentModel?
    
    public func setup(model: InvestimentModel) {
        self.selectionStyle = .none
        self.model = model
        
        companyIcon.backgroundColor = .red
        companyIcon.tintColor = .red
        
        self.investimentName.text = model.investimentName
        self.investimentName.sizeToFit()
        
        self.companyName.text = model.companyName
        self.companyName.sizeToFit()
        
        favouriteIcon.backgroundColor = .blue
        favouriteIcon.tintColor = .blue
        
        self.price.text = model.price
        self.price.sizeToFit()
        
        self.difference.text = model.dynamic
        self.difference.sizeToFit()
    }
}
