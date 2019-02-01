//
//  QuizzesVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizzesVC: UIViewController {
    
    var quizview = QuizzesView()
    
    var quizCellId = "Quiz"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizview)
        tabBarItem.image = UIImage(named: "quiz-icon")
        quizview.myCollectionView.delegate = self
        quizview.myCollectionView.dataSource = self
    }
    
}
extension QuizzesVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizview.myCollectionView.dequeueReusableCell(withReuseIdentifier: quizCellId, for: indexPath) as! QuizzesCell
        cell.titleLabel.text = "The Quizes That I Favorite will be displayed here"
        return cell
        
    }
    
    
}
