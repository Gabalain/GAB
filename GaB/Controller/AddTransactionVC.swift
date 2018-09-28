//
//  AddTransactionVC.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class AddTransactionVC: UIViewController, UITextFieldDelegate {
    
//    var transactions: Results<Transaction>?
    var categories: Results<Category>?
    var accounts: Results<Account>?

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var dayPicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var accountPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTxt.delegate = self
        self.amountTxt.delegate = self

        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        self.accountPicker.delegate = self
        self.accountPicker.dataSource = self

        categories = loadCategories()
        accounts = loadAccounts()
        print("Categories: ", categories)
        print("Accounts: ", accounts)
        
        // To set Categories and Accounts only
        // setAccounts()
        // setCategories()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let transactionTitle = validText(titleTxt, errorMessage: "Le titre de la transaction est obligatoire.\nMerci de le renseigner.", forVC: self),
            let transactionAmount = validNum(amountTxt, errorMessage: "Valeur entrée non valide.\nFormat: xxx,xx", forVC: self)
            else  { return }
        
        // Create NewTransaction with correct values and save it
        let newTransaction = Transaction()
        newTransaction.title = transactionTitle
        newTransaction.amount = transactionAmount
        newTransaction.date = self.dayPicker.date
        saveTransaction(newTransaction)
        
        // Save Category in list
        
        // Save Account in list

        
        // dismiss modal and go back to transactions List
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        // dismiss modal and go back to transactions List
        dismiss(animated: true, completion: nil)
    }
}

extension AddTransactionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // Pickers Fillin
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categories!.count
        } else if pickerView == accountPicker {
            return accounts!.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            return categories![row].name
        } else if pickerView == accountPicker {
            return accounts![row].name
        }
        return "Vide"
    }
}




