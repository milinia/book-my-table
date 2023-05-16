//
//  CustomTextField.swift
//  BookMyTable
//
//  Created by Evelina on 15.05.2023.
//

import UIKit

class CustomTextField: UITextField {

    let inset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 10)
       
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
       
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
}
