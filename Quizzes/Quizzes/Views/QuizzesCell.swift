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
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        let pic = UIImage(named: "more-filled")
        button.setImage(pic, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabelConstraints()
         buttonConstraints()
        backgroundColor = .white
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension QuizzesCell{
    
    func buttonConstraints(){
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        optionsButton.bottomAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    }
    
    func nameLabelConstraints(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
