//
//  TableView+Extenttion.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func nextResponder(index: Int){
        var currentIndex = -1
        for i in index+1..<index+100{
            if let view = self.superview?.superview?.viewWithTag(i){
                view.becomeFirstResponder()
                currentIndex = i
                break
            }
        }
        
        let ind = IndexPath(row: currentIndex, section: 0)
        if let nextCell = self.cellForRow(at: ind){
            self.scrollRectToVisible(nextCell.frame, animated: true)
        }
    }
}
