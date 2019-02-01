//
//  SearchCell.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    //MANDATORY PROGRAMMATIC UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.backgroundColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("...", for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabelConstraints()
        optionsButtonConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SearchCell{
    func optionsButtonConstraints(){
        addSubview(optionsButton)
         optionsButton.translatesAutoresizingMaskIntoConstraints = false
         optionsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
         optionsButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
         optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func titleLabelConstraints(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}
