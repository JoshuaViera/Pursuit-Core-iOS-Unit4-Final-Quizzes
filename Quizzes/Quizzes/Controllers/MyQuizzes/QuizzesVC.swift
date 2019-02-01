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
    var allQuizzes = [Quizzes](){
        didSet{
            DispatchQueue.main.async {
                self.quizview.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizview)
        quizview.myCollectionView.delegate = self
        quizview.myCollectionView.dataSource = self
        getData()
    }
    
    func getData() {
        APIClient.getQuizQuestions { (error, quiz) in
            if let error = error {
                print(AppError.networkError(error))
            }
            if let quiz = quiz {
                self.allQuizzes = quiz
                dump(quiz)
                //do some more logic here
            }
        }
    }
}
extension QuizzesVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizview.myCollectionView.dequeueReusableCell(withReuseIdentifier: quizCellId, for: indexPath) as! QuizzesCell
        let quiz = allQuizzes[indexPath.row]
        cell.titleLabel.text = quiz.quizTitle
        return cell
        
    }
    
    
}
