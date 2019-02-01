//
//  SearchVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var searchview = SearchView()
    var searchCellId = "Search"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchview)
        tabBarItem.image = UIImage(named: "quiz-icon")
        searchview.myCollectionView.delegate = self
        searchview.myCollectionView.dataSource = self
    }
    



}
extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchview.myCollectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath) as! SearchCell
        cell.titleLabel.text = "These Quizzes will Be Displayed From the API"
        return cell
    }
    
    
}
