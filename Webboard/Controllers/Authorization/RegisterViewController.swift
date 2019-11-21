//
//  RegisterViewController.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    var activeTextField: UITextField?
    
    let datePicker: UIDatePicker = UIDatePicker()
    let pickerView: UIPickerView = UIPickerView()
    // View tye table view
    let numberOfRow = 7
    let rowOfFirstName = 0
    let rowOfLastName = 1
    let rowOfBirthDate = 2
    let rowOfGender = 3
    let rowOfAddress = 4
    let rowOfEmail = 5
    let rowOfPassword = 6
    
    // var
    var firstname: String?
    var lastname: String?
    var birthDate: String?
    var gender: Gender?
    var address: String?
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 4.0
        confinTableView()
    }
    
    private func confinTableView(){
        tableView.register(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Add keyboadr obswever
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(with:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(with:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        view.endEditing(true)
    }
    
    // MARK: - Handle keyboard
    @objc func keyboardDidShow(with notification: Notification) {
        
        guard let textField = activeTextField else {
            return
        }
        
        print("keyboardDidShow")
        guard let userInfo = notification.userInfo, let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        print("keyboard height: \(value.cgRectValue.height)")
        print("View height: \(view.frame.size.height)")
        
        let contentInsset = UIEdgeInsets(top: 0, left: 0, bottom: value.cgRectValue.height - buttonHeight.constant, right: 0)
        tableView.contentInset = contentInsset
        tableView.scrollIndicatorInsets = contentInsset
        
        var aRect = view.frame
        aRect.size.height -= value.cgRectValue.height
        
        if !aRect.contains(textField.frame.origin){
            tableView.scrollRectToVisible(textField.frame, animated: true)
        }
        
    }
    
    @objc func keyboardWillHide(with notification: Notification){
        print("keyboardWillHide")
        
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    //    @objc func changeBirthDay(_ sender: UIDatePicker) {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.locale = Locale(identifier: "th_TH")
    //        dateFormatter.dateFormat = "dd MMM yyyy"
    //
    //        birthDate = dateFormatter.string(from: datePicker.date)
    //        sender.isHidden = false
    //        tableView.reloadRows(at: [IndexPath(row: rowOfBirthDate, section: 0)], with: .automatic)
    //    }
    // MARK: - Picker view & date picker view
    private func showDatePicker(in textField: UITextField){
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .buddhist)
        datePicker.locale = Locale(identifier: "th_TH")
        //        datePicker.addTarget(self, action: #selector(changeBirthDay(_ :)), for: .valueChanged)
        textField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "เสร็จ", style: .done, target: nil, action: #selector(addDateButtonTapped(_:)))
        let cancelButton = UIBarButtonItem(title: "ยกเลิก", style: .done, target: nil, action: #selector(cancelDateButtonTapped(_:)))
        let fiexileSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, fiexileSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    private func showGenderPicker(in textField: UITextField) {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        textField.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "เสร็จ", style: .done, target: nil, action: #selector(addGenderButtonTapped(_ :)))
        let cancelButton = UIBarButtonItem(title: "ยกเลิก", style: .done, target: nil, action: #selector(cancelDateButtonTapped(_:)))
        let fiexileSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, fiexileSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    // MARK: - Setup cell
    private func cellForFirstName(_ indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: firstname, placeholder: "First Name", indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForLastName(_ indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: lastname, placeholder: "Last Name", indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForBirthDate(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: birthDate, placeholder: "Birth date", indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForGender(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: gender?.text, placeholder: "Gender", indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForAddress(_ indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: address, placeholder: "Address", indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForEmail(_ indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: email, placeholder: "Email", keyboardType: .emailAddress, indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func cellForPassword(_ indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputTableViewCell
        cell.setup(text: password, placeholder: "Password", isSecureTextEntry: true, indexPath: indexPath.row, numberOfRow: numberOfRow)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    // MARK: - Action
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        register()
    }
    
    @objc func addDateButtonTapped(_ sender: UIBarButtonItem){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "th_TH")
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        birthDate = dateFormatter.string(from: datePicker.date)
        tableView.reloadRows(at: [IndexPath(row: rowOfBirthDate, section: 0)], with: .automatic)
    }
    
    @objc func addGenderButtonTapped(_ sender: UIPickerView) {
        let row = pickerView.selectedRow(inComponent: 0)
        gender = Gender.allCases[row]
        tableView.reloadRows(at: [IndexPath(row: rowOfGender, section: 0)], with: .automatic)
    }
    
    @objc func cancelDateButtonTapped(_ sender: UIBarButtonItem){
        view.endEditing(true)
    }
    
    // MARK: - Validation
    private func validateAll()->Bool{
        
        guard validateEmail() else {
            return false
        }
        
        guard validateNormalTextField(yourField: firstname) else {
            return false
        }
        
        guard validateNormalTextField(yourField: lastname) else {
            return false
        }
        
        guard validateNormalTextField(yourField: address) else {
            return false
        }
        
        guard validatePassword() else {
            return false
        }
        
        return true
    }
    
    private func validateNormalTextField(yourField: String?) -> Bool {
        
        guard let text = yourField, !text.isEmpty else {
            showError(title: "Error", message: "Text is empty")
            return false
        }
        
        return true
    }
    
    private func validateEmail()-> Bool{
        
        guard let text = email, !text.isEmpty else {
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
        guard let text = password, !text.isEmpty else {
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
    private func register(){
        // 1.
        let params = ["name": "\(firstname!) \(lastname!)",
            "email": "\(email!)",
            "password": "\(password!)"
        ]
        
        // 2.
        guard let url = URL(string: "http://localhost:8080/api/v1.0/users") else { return }
        
        var request = URLRequest(url: url)
        
        // 3.
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
        } catch {
            print(error.localizedDescription)
        }
        
        // 4. // Callback
        let task =  URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            do {
                
                let json: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                print(json)
                
            }
            catch let err as NSError{
                print(err.localizedDescription);
            }
        })
        
        // 5. run
        task.resume()
        
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

extension RegisterViewController: UITableViewDataSource, UITableViewDelegate{
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 5
    //    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Section: \(section)"
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case rowOfFirstName:
            return cellForFirstName(indexPath)
        case rowOfLastName:
            return cellForLastName(indexPath)
        case rowOfBirthDate:
            return cellForBirthDate(indexPath)
        case rowOfGender:
            return cellForGender(indexPath)
        case rowOfAddress:
            return cellForAddress(indexPath)
        case rowOfEmail:
            return cellForEmail(indexPath)
        case rowOfPassword:
            return cellForPassword(indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension RegisterViewController: InputTableViewCellDelegate{
    
    func inputTableViewCell(_ inputTableViewCell: InputTableViewCell, didBeginEditingTextField textField: UITextField) {
        activeTextField = textField
        
        switch inputTableViewCell.tag {
        case rowOfBirthDate:
            showDatePicker(in: textField)
        default:
            showGenderPicker(in: textField)
        }
    }
    
    func inputTableViewCell(_ InputTableViewCell: InputTableViewCell, didEndEditingTextField textField: UITextField) {
        activeTextField = nil
    }
    
    func inputTableViewCell(_ InputTableViewCell: InputTableViewCell, didInputText text: String?) {
        
        switch InputTableViewCell.tag {
        case rowOfFirstName:
            firstname = text
        case rowOfLastName:
            lastname = text
        case rowOfAddress:
            address = text
        case rowOfEmail:
            email = text
        case rowOfPassword:
            password = text
        default:
            break
        }
    }
    
    func inputTableViewCell(_ InputTableViewCell: InputTableViewCell, nextTextFieldAt tag: Int) {
        let nextTag = tag+1
        
        if let nextTextField = tableView.cellForRow(at: IndexPath(row: nextTag, section: 0)) {
            nextTextField.becomeFirstResponder()
        }else{
            InputTableViewCell.textField.resignFirstResponder()
        }
    }
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let gender = Gender.allCases[row]
        return gender.text
    }
}
