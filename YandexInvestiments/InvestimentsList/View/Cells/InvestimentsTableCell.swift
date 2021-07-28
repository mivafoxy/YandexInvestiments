//
//  InvestimentsTableCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 09.06.2021.
//

import UIKit

class InvestimentsTableCell: UITableViewCell {

    @IBOutlet weak var companyLabelView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var investimentName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var favouriteIcon: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    
    public var model: InvestimentModel?
    
    public func setup(model: InvestimentModel) {
        self.selectionStyle = .none
        self.model = model
        
        guard let companyName = model.companyName else { return }
        
        companyLabel.text = "\(companyName[companyName.startIndex])"
        companyLabel.sizeToFit()
        
        companyLabelView.backgroundColor = getRandomColor()
        
        self.investimentName.text = model.symbol
        self.investimentName.sizeToFit()
        
        self.companyName.text = model.companyName
        self.companyName.sizeToFit()
        
        if model.isFavourite! {
            self.favouriteIcon.image = UIImage(systemName: "star.fill")
        } else {
            self.favouriteIcon.image = UIImage(systemName: "star")
        }
        
        
        self.price.text = model.regularPrice
        self.price.sizeToFit()
        
        self.difference.text = model.dynamic
        self.difference.sizeToFit()
        
        if model.isGrowing {
            self.difference.textColor = .green
        } else {
            self.difference.textColor = .red
        }
    }
    
    private func getRandomColor() -> UIColor {
        let supportedColors: [UIColor] = [ .yellow, .blue, .brown, .cyan, .magenta, .orange ]
        return supportedColors.randomElement()!
    }
}
