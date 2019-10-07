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
    
    // View tye table view
    let numberOfRow = 5
    let rowOfFirstName = 0
    let rowOfLastName = 1
    let rowOfAddress = 2
    let rowOfEmail = 3
    let rowOfPassword = 4
    
    // var
    var firstname: String?
    var lastname: String?
    var address: String?
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confinTableView()
    }
    
    private func confinTableView(){
        tableView.register(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputCell")
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
//        return 10
//    }
//
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
    func InputTableViewCell(_ InputTableViewCell: InputTableViewCell, didInputText text: String?) {
        
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
    
    func InputTableViewCell(_ InputTableViewCell: InputTableViewCell, nextTextFieldAt tag: Int) {
        let nextTag = tag+1
        
        if let nextTextField = tableView.cellForRow(at: IndexPath(row: nextTag, section: 0)) {
            nextTextField.becomeFirstResponder()
        }else{
            InputTableViewCell.textField.resignFirstResponder()
        }
    }
}
