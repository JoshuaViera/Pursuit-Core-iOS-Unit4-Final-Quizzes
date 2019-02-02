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
    var quizzes = [Quiz](){
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
        setItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        setItems()
        self.searchview.myCollectionView.reloadData()
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
    func setItems() {
        self.searchview.myCollectionView.reloadData()
        self.quizzes = QuizModel.getItems()
    }
    
    @objc func addPhotoButtonPressed(sender: UIButton){
        let index = sender.tag
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let save = UIAlertAction(title: "Save", style: .default) { (alert) in
            self.setItems()
        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "QuizzesVC") as? QuizzesVC else {return}
//        navigationController?.pushViewController(vc, animated: true)
        self.setItems()
        let itemDescription = allQuizzes[index].quizTitle
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        let item = Quiz.init(description: itemDescription, createdAt: timeStamp)
        
        QuizModel.addItem(item: item)
        actionSheet.addAction(cancel)
        actionSheet.addAction(save)
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
        cell.addButton.addTarget(self, action: #selector(addPhotoButtonPressed(sender:)), for: .touchUpInside )
        
        return cell
    }
    
    
}
