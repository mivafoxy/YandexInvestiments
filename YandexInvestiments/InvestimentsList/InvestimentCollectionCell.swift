//
//  InvestimentCollectionCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 09.06.2021.
//

import UIKit

class InvestimentCollectionCell: UICollectionViewCell {

    @IBOutlet weak var sectionName: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setup(sectionName: String) {
        self.sectionName.text = sectionName
        self.sectionName.sizeToFit()
    }
    
    public func makeSelected() {
        isSelected = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.sectionName.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
    }
}
