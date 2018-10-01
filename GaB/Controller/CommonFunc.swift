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
    return formatter.string(from: date)
}

func floatToString(_ number: Float, _ digits: Int) -> String {
    if (number == 0) { return "0,00" }
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    formatter.groupingSeparator = " "
    formatter.minimumFractionDigits = digits
    formatter.maximumFractionDigits = digits
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}

func validText(_ text: UITextField, errorMessage message: String, forVC sender: UIViewController) -> String? {
    if let text = text.text, text != ""
    { return text }
    OperationQueue.main.addOperation
        { showAlert(title: "Error!", message: message, viewController: sender) }
    return nil
}

func validNum(_ text: UITextField, errorMessage message: String, forVC sender: UIViewController) -> Float? {
    if let num = text.text
    { return Float(num) }
    OperationQueue.main.addOperation
        { showAlert(title: "Error!", message: message, viewController: sender) }
    return nil
}

func setCategories() {
    let categ1 = Category()
    categ1.name = "Vie courante"
    categ1.color = "AA3333"
    saveCategory(categ1)
    
    let categ2 = Category()
    categ2.name = "Pret Immo"
    categ2.color = "33AA33"
    saveCategory(categ2)
    
    let categ3 = Category()
    categ3.name = "Enfants"
    categ3.color = "3333AA"
    saveCategory(categ3)
}

func setAccounts() {
    let acc1 = Account()
    acc1.name = "AXA 1503"
    acc1.image = "Axa"
    saveAccount(acc1)
    
    let acc2 = Account()
    acc2.name = "VISA 6230"
    acc2.image = "Visa"
    saveAccount(acc2)
    
    let acc3 = Account()
    acc3.name = "AXA 1305"
    acc3.image = "Axa"
    saveAccount(acc3)

}

//func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//    let size = image.size
//
//    let widthRatio  = targetSize.width  / size.width
//    let heightRatio = targetSize.height / size.height
//
//    // Figure out what our orientation is, and use that to form the rectangle
//    var newSize: CGSize
//    if(widthRatio > heightRatio) {
//        newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
//    } else {
//        newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
//    }
//
//    // This is the rect that we've calculated out and this is what is actually used below
//    let rect = CGRectMake(0, 0, newSize.width, newSize.height)
//
//    // Actually do the resizing to the rect using the ImageContext stuff
//    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//    image.drawInRect(rect)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return newImage
//}

