//
//  String+Extension.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import Foundation

extension String{
    var isEmail: Bool {
        let reg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        guard let range = self.range(of: reg, options: [.regularExpression, .caseInsensitive]), range.lowerBound == self.startIndex && range.upperBound == self.endIndex else {
            return false
        }
        
        return true
    }
}
