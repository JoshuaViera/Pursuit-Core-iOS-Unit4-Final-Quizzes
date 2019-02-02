//
//  QuizzesDetailVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizzesDetailVC: UIViewController {
    
    var quizDetailView = QuizzesDetailView()
    var quizFacts = [String]()
    var quiz = [Quizzes]()
    var quizDetailCellId = "detail"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizDetailView)
        quizDetailView.myCollectionView.delegate = self
        quizDetailView.myCollectionView.dataSource = self
    }
    

    override func viewWillLayoutSubviews() {
        quizDetailView.myCollectionView.reloadData()
    }


}
extension QuizzesDetailVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizDetailView.myCollectionView.dequeueReusableCell(withReuseIdentifier: quizDetailCellId, for: indexPath) as! QuizzesDetailCell
         cell.titleLabel.text = quizFacts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hello")
    }
    
}
