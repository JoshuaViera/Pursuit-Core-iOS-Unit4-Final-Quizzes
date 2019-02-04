//
//  ProfileVC.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UIButton!
    var loginName = ""
    let imagePicker =  UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        title = "Profile"
        setProfileImageToCircle()
        loginAlertPrompt()
        
    }
    func setProfileImageToCircle(){
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / .pi
        profileImage.clipsToBounds = true
    }
    func loginAlertPrompt(){
        if profileName.titleLabel?.text == "@loginName" {
            
            let alert = UIAlertController(title: "Create a Profile Name:", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your name here..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                if let name = alert.textFields?.first?.text {
                    self.profileName.titleLabel?.text = "@\(name)"
                    self.loginName = name
                    UserDefaults.standard.set(self.loginName, forKey: UserDefaultKeys.userDefaultKey)
                }
            }))
            
            self.present(alert, animated: true)
            
            
        } else {
            profileName.titleLabel!.text = (UserDefaults.standard.object(forKey: UserDefaultKeys.userDefaultKey) as! String)
        }
    }
    
    @IBAction func profileImage(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
}
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\ninfo: \(info)\n")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
            
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}

