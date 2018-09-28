//
//  commonFunc.swift
//  GaB
//
//  Created by Alain Gabellier on 28/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit


extension Float {
    init(_ value: String){
        self = (value as NSString).floatValue
    }
}

func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertVC.addAction(action)
    viewController.present(alertVC, animated: true)
}

func dateToString(_ date: Date, _ stringFormat: String?) -> String {
    let formatter = DateFormatter()
    if let stringFormat = stringFormat {
        formatter.dateFormat = stringFormat
    } else {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    return formatter.string(from: date) // string purpose I add here
}

func floatToString(_ number: Float, _ digits: Int) -> String {
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    formatter.groupingSeparator = " "
    formatter.minimumFractionDigits = digits
    formatter.maximumFractionDigits = digits
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}



