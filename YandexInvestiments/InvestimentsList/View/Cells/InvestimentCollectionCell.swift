//
//  InvestimentCollectionCell.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 09.06.2021.
//

import UIKit

class InvestimentCollectionCell: UICollectionViewCell {

    @IBOutlet weak var sectionName: UILabel!
    
    private var isTransformed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setup(sectionName: String) {
        self.sectionName.text = sectionName
        self.sectionName.sizeToFit()
    }
    
    public func makeSelected() {
        if isSelected {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.isTransformed = false
                self.sectionName.transform =
                    CGAffineTransform.identity
                    .scaledBy(x: 1.0, y: 1.0)
            }
        }
    }
    
    public func makeUnselected() {
        if !isSelected && !isTransformed {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//                let translationX = self.sectionName.frame.minX - self.frame.width * 0.2
//                let translationY = self.sectionName.frame.maxY - self.frame.height * 0.8
//
//                let translationX = -(self.frame.width - self.sectionName.frame.width) / 2.0
//                let translationY = (self.frame.height - self.sectionName.frame.height) / 2.0
                self.sectionName.transform =
                    CGAffineTransform.identity
                    .scaledBy(x: 0.8, y: 0.8)
//                    .translatedBy(x: translationX, y: translationY)
                
                self.isTransformed = true
            }
        }
    }
}
