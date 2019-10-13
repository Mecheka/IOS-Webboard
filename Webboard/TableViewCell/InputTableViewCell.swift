//
//  InputTableViewCell.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

protocol InputTableViewCellDelegate: class {
    func inputTableViewCell(_ inputTableViewCell: InputTableViewCell, didInputText text: String?)
    func inputTableViewCell(_ inputTableViewCell: InputTableViewCell, nextTextFieldAt tag: Int)
    func inputTableViewCell(_ inputTableViewCell: InputTableViewCell, didBeginEditingTextField textFiele: UITextField)
    func inputTableViewCell(_ inputTableViewCell: InputTableViewCell, didEndEditingTextField textFiele: UITextField)
}

class InputTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    weak var delegate: InputTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    func setup(text: String?, placeholder: String, keyboardType: UIKeyboardType = .default,
               isSecureTextEntry: Bool = false, indexPath:Int, numberOfRow: Int) {
        if numberOfRow - 1 == indexPath{
            textField.returnKeyType = .done
        }else{
            textField.returnKeyType = .next
        }

        textField.text = text
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry

        tag = 0
        delegate = nil
    }
    
    private func clear(){
        
        textField.text = nil
        textField.placeholder = "Input Text Here"
        textField.keyboardType = .default
        textField.isSecureTextEntry = false
    }
}

extension InputTableViewCell: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.inputTableViewCell(self, didBeginEditingTextField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.inputTableViewCell(self, didEndEditingTextField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.inputTableViewCell(self, nextTextFieldAt: textField.tag)
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        delegate?.inputTableViewCell(self, didInputText: newString)
        return true
    }
}
