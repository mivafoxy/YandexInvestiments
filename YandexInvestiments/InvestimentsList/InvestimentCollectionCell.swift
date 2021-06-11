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
}
