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
    
    @objc func buttonPressed(sender: UIButton){
        let index = sender.tag
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
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
        
        cell.optionsButton.tag = indexPath.row
        cell.optionsButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside )
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = allQuizzes[indexPath.row].facts
        let detailVC = QuizzesDetailVC()
        detailVC.quizFacts = title
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
