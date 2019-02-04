//
//  CreateQuizzesVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateQuizzesVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var factOneTextView: UITextView!
    @IBOutlet weak var factTwoTextView: UITextView!
    
    private let titlePlaceholder = "Title"
    private let firstFactPlaceholder = "Fact One....."
    private let secondFactPlaceholder = "Fact Two....."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    func setupViews() {
        factOneTextView.delegate = self
        factTwoTextView.delegate = self
        factOneTextView.text = firstFactPlaceholder
        factOneTextView.textColor = .lightGray
        factTwoTextView.textColor = .lightGray
        factTwoTextView.text = secondFactPlaceholder
        //
        titleTextField.delegate = self
        titleTextField.text = titlePlaceholder
        titleTextField.textColor = .lightGray
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
       titleTextField.text = ""
        factOneTextView.text = ""
        factTwoTextView.text = ""
        let vc = QuizzesVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func createPostButton(_ sender: UIBarButtonItem) {
        
        if titleTextField.text == titlePlaceholder || factOneTextView.text == firstFactPlaceholder || factTwoTextView.text == secondFactPlaceholder {
            let alert = UIAlertController(title: "All Fields Must Be Filled", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        } else if titleTextField.text == nil || factOneTextView.text == nil || factTwoTextView.text == nil {
            let alert = UIAlertController(title: "All Fields Must Be Filled", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        } else {
            guard let itemDescription = titleTextField.text else {
                fatalError("no title")
            }
            let date = Date()
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
            let timeStamp = isoDateFormatter.string(from: date)
            let item = Quiz.init(description: itemDescription, createdAt: timeStamp)
            QuizModel.addItem(item: item)
            let vc = QuizzesVC()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}
extension CreateQuizzesVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == factOneTextView {
            if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
            }
        } else if textView == factTwoTextView {
            if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == factOneTextView {
            if textView.text.isEmpty {
                textView.text = firstFactPlaceholder
                textView.textColor = .lightGray
            }
        } else if textView == factTwoTextView{
            if textView.text.isEmpty {
                textView.text = secondFactPlaceholder
                textView.textColor = .lightGray
            }
        }
    }
}
extension CreateQuizzesVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
            if textField.textColor == .lightGray {
                textField.text = nil
                textField.textColor = .black
            }
        }
    }
 
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == titleTextField {
            if textField.text!.isEmpty {
                textField.text = titlePlaceholder
                textField.textColor = .lightGray
            }
        }
    }
}
