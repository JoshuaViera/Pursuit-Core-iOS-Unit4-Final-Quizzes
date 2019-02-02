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
    
    var allQuizzes = [Quizzes](){
        didSet{
            DispatchQueue.main.async {
                self.searchview.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchview)
        searchview.myCollectionView.delegate = self
        searchview.myCollectionView.dataSource = self
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
extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchview.myCollectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath) as! SearchCell
        cell.titleLabel.text = allQuizzes[indexPath.row].quizTitle
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside )
        
        return cell
    }
    
    
}
