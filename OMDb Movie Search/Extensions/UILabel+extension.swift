//
//  UILabel+extension.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 25/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

extension UILabel {
    
    func setBlackOutlinedText(text: String) {
        
        let strokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -2.0,
            ]
        
        self.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
        
    }
    
}
