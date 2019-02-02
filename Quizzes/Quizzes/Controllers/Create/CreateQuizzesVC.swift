//
//  CreateQuizzesVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateQuizzesVC: UIViewController {

    var createView = CreateQuizzesView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createView)
    }
}
