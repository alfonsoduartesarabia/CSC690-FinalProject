//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Alfonso Duarte on 5/5/21.
//

import UIKit
//import FirebaseDatabase
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    // var databaseReference = Database.database().reference()
    var docRef: DocumentReference? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //signUp.isEnabled = false
    }
    
    // Once user presses sign up button
    @IBAction func didSignUp(_ sender: UIButton) {
//        email.resignFirstResponder()
//        password.resignFirstResponder()
        //signUp.isEnabled = false
        
        // Validate the fields
        if validateFields() == nil,
           let emailText = email.text, let passwordText = password.text,
           let usernameText = userName.text, let firstnameText = firstName.text,
           let lastnameText = lastName.text{
            
            // Firebase create user
            Auth.auth().createUser(withEmail: emailText, password: passwordText, completion: { [weak self]
                authResult, error in
                guard let strongSelf = self else {
                    return
                }
                guard let result = authResult, error == nil else{
                    print(error.debugDescription)
                    print("Error creating user!")
                    return
                }
                let user = result.user
                print("Created User: \(user)")
                
                // add other information to firestore database
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstname": firstnameText, "lastname": lastnameText,
                                                          "username": usernameText, "uid": result.user.uid], completion: { (error) in
                                                            if error != nil{
                                                                print("Error when saving user data")
                                                            }
//                                                            else{
//                                                                print("Document added with ID: \(self!.docRef!.documentID)")
//                                                            }

                                                          })
                
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                self?.transitiontoHomeScreen()
            })
            
            // Transition to home screen
            //self.transitiontoHomeScreen()
        }
    }
    
    //  check all fields are filled out
    func validateFields() -> String?{
        
        var message: String = ""
        
        guard let emailText = email.text,
              !emailText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let passwordText = password.text,
           !passwordText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let firstNameText = firstName.text,
           !firstNameText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let lastNameText = lastName.text,
           !lastNameText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let usernameText = userName.text,
           !usernameText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            
            message = "Please fill all fields"
            alertUserAllFields(message)
            return message
        }
        
        if !checkEmail(emailText){
            message = "Incorrect email entry"
            alertEmail(message)
            return message
        }
        
        let cleanedPassword = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !checkPassword(cleanedPassword){
            message =
                "Password needs to contain at least 8 characters, one special character, one uppercase, one lowercase, and one number"
            alertPassword(message)
            return message
        }
        
        return nil
    }
    
    // check email using regex
    func checkEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // check password using regular expressions
    func checkPassword(_ password: String) -> Bool{
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordCheck.evaluate(with: password)
    }
    
    // Alert for incorrect email
    func alertEmail(_ message: String){
        let alert = UIAlertController(title: "Email Entry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Alert for incorrect password
    func alertPassword(_ message: String){
        let alert = UIAlertController(title: "Password Entry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Alert for when user does not fill all fields
    func alertUserAllFields(_ message: String){
        let alert = UIAlertController(title: "Sign Up Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func transitiontoHomeScreen(){
        let feedVC = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.feedViewController) as? FeedViewController
        
        view.window?.rootViewController = feedVC
        view.window?.makeKeyAndVisible()
    }
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
