//
//  CardViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 10.06.2021.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var sectionsCollection: UICollectionView!
    
    private let cellId = String(describing: CardViewController.self)
    
    private let sections = [
        "Chart",
        "Sumary",
        "News",
        "Forecasts",
        "Ideas"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectionsCollection.dataSource = self
        sectionsCollection.register(
            UINib(nibName: String(describing: CardViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CardViewCell else {
            return UICollectionViewCell()
        }
        
        cell.sectionName.font = .systemFont(ofSize: 18.0)
        cell.setup(sectionName: sections[indexPath.row])
        
        return cell
    }
}
