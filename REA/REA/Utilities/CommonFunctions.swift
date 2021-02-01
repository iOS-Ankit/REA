//
//  CommonFunctions.swift
//  REA
//
//  Created by MSS on 30/01/21.
//

import Foundation
import UIKit

class CommonFunctions {
    
    public static let sharedInstance = CommonFunctions()
    
    // MARK: Date helper functions
    
    func formatedDate(_ format: String, _ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let selectedDate = dateFormatter.string(from: date)
        return selectedDate
    }
    
    // MARK: Show Alert
    
    func showAlert(_ message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "Event APP", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
