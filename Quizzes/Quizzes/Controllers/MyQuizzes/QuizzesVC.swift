//
//  QuizzesVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

enum Functions {
    case edit
    case save
}

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
    var items = [Quiz](){
        didSet{
            DispatchQueue.main.async {
                self.quizview.myCollectionView.reloadData()
            }
        }
    }
    var functions: Functions!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizview)
        quizview.myCollectionView.delegate = self
        quizview.myCollectionView.dataSource = self
        print(DataPersistenceManager.documentsDirectory())
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
    
    @objc func buttonPressed(sender: UIButton){
        let index = sender.tag
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            QuizModel.delete(atIndex: index)
        }
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
}



extension QuizzesVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuizModel.getItems().count
//        return allQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizview.myCollectionView.dequeueReusableCell(withReuseIdentifier: quizCellId, for: indexPath) as! QuizzesCell
//        let quiz = items[indexPath.row]
//        cell.titleLabel.text = quiz.description
        cell.optionsButton.tag = indexPath.row
        cell.optionsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside )
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = allQuizzes[indexPath.row].quizTitle
        let facts = allQuizzes[indexPath.row].facts
        let detailVC = QuizzesDetailVC()
        detailVC.quizFacts = facts
        detailVC.quiz = title
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
