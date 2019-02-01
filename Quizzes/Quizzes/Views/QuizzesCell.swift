//
//  QuizzesCell.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizzesCell: UICollectionViewCell {
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
        nameLabelConstraints()
         buttonConstraints()
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension QuizzesCell{
    func nameLabelConstraints(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func buttonConstraints(){
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        optionsButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}
