//
//  LoginViewController.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email.tag = 1
        password.tag = 2
    }
    
    // MARK: - Action
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard validateAll() else {
            // Alert
            return
        }
        
        // Call service
        login()
    }
    
    // MARK: - Validation
    private func validateAll()->Bool{
        
        guard validateEmail() else {
            return false
        }
        
        guard validatePassword() else {
            return false
        }
        
        return true
    }
    
    private func validateEmail()-> Bool{
        
        guard let text = email.text, !text.isEmpty else {
            showError(title: "Error", message: "Email is empty")
            return false
        }
        
        guard text.isEmail else {
            showError(title: "Error", message: "Email is invalidformat")
            return false
        }
        return true
    }
    
    private func validatePassword()->Bool{
        guard let text = password.text, !text.isEmpty else {
            showError(message: "Password is empty")
            return false
        }
        return true
    }
    
    // MARK: - Alert
    private func showError(title: String? = nil, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            //
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Service
    private func login(){
        service.login(username: email.text!, password: password.text!) { [weak self] result in
            switch result {
            case .success(let loginRespone):
                AuthorizationManager.shared.token = loginRespone.string
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                window?.rootViewController?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self?.showError(message: error.localizedDescription)
            }
        }
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

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextField = textField.superview?.viewWithTag(nextTag){
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return true
    }
}
