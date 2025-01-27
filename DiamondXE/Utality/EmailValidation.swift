//
//  EmailValidation.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/05/24.
//

import Foundation
import UIKit
class EmailValidation {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
