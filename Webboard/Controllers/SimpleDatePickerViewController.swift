//
//  SimpleDatePickerViewController.swift
//  Webboard
//
//  Created by Suriya on 13/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class SimpleDatePickerViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inputTextField.inputView = datePicker
        inputTextField.inputAccessoryView = toolbar
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

extension SimpleDatePickerViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
