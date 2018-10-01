//
//  ViewController.swift
//  GaB
//
//  Created by Alain Gabellier on 26/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import MobileCoreServices
import SwiftSoup

class TransactionsVC: UIViewController {
    
    @IBOutlet weak var transactionsTV: UITableView!
    @IBOutlet weak var axaBtn: UIButton!
    @IBOutlet weak var visaBtn: UIButton!
    @IBOutlet weak var othersBtn: UIButton!
    
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var outcomeLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    var transactions: Results<Transaction>?
    var categories: Results<Category>?
    var accounts: Results<Account>?
    
    var accountSelected: String!
    var monthSelected: Int!
    var yearSelected: Int!
    
    var transactionSelected: Transaction?
    var totalIncome: Float?
    var totalOutcome: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Supposed to turn Status bar to white !!!
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        transactionsTV.delegate = self
        transactionsTV.dataSource = self
        
        // Set Month and year to actuals
        yearSelected = Int(dateToString(Date(), "yyyy"))
        monthSelected = Int(dateToString(Date(), "MM"))
        
        // Trigger AXA pressed to update data and Title
        axaBtn.sendActions(for: .touchUpInside)
        
        categories = loadCategories()
        accounts = loadAccounts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Transaction: ", transactions!)
        
        transactionsTV.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func resetTransactionsPressed(_ sender: Any) {
        resetTransactions()
        transactionsTV.reloadData()
    }
    
    @IBAction func axaBtnPressed(_ sender: UIButton) {
        setTitleAndBtns(button: sender)
    }
    @IBAction func visaBtnPressed(_ sender: UIButton) {
        setTitleAndBtns(button: sender)
    }
    @IBAction func otherBtnPressed(_ sender: UIButton) {
        setTitleAndBtns(button: sender)
    }
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        monthSelected -= 1
        if monthSelected < 1 { monthSelected = 12; yearSelected -= 1 }
        setTitleAndBtns(button: sender)
    }
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        monthSelected += 1
        if monthSelected > 12 { monthSelected = 1; yearSelected += 1 }
        setTitleAndBtns(button: sender)
    }
    
    @IBAction func addTransactionsbtnPressed(_ sender: Any) {
        // must import MobileCoreServices first
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let transactions = transactions else { return 1 }
        
        totalIncome = 0.0
        totalOutcome = 0.0
        
        for transaction in transactions {
            let amount = transaction.amount
            print(amount)
            if amount >= 0 {
                totalIncome = totalIncome! + amount
            } else {
                totalOutcome = totalOutcome! + amount
            }
        }
        incomeLbl.text = floatToString(totalIncome!, 2)
        outcomeLbl.text = floatToString(totalOutcome!, 2)
        balanceLbl.text = floatToString(totalIncome! + totalOutcome!, 2)
        if totalIncome! >= totalOutcome! {
            balanceLbl.textColor = UIColor.flatGreen
        } else {
            balanceLbl.textColor = UIColor.flatRed
        }
        
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = transactionsTV.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionCell else { return TransactionCell() }
        cell.configureCell(withTransaction: transactions![indexPath.row], atIndex: indexPath.row)
        
        return cell
    }
    
}

extension TransactionsVC {

    func changeBtnFont(button: UIButton, fontName: String, fontSize: CGFloat) {
        var descriptor = UIFontDescriptor(name: fontName, size: fontSize)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
        button.titleLabel!.font = UIFont(descriptor: descriptor, size: 20)
    }
    
    func setTitleAndBtns(button: UIButton) {
        if let accountName = button.titleLabel?.text { // AXA VISA or Autres Pressed
            print("Button pressed: ",accountName)
            // Update Buttons font
            changeBtnFont(button: axaBtn, fontName: "HelveticaNeue-Thin", fontSize: 18.0)
            changeBtnFont(button: visaBtn, fontName: "HelveticaNeue-Thin", fontSize: 18.0)
            changeBtnFont(button: othersBtn, fontName: "HelveticaNeue-Thin", fontSize: 18.0)
            switch accountName {
            case "AXA":
                accountSelected = "AXA 1503"
                changeBtnFont(button: axaBtn, fontName: "HelveticaNeue-Bold", fontSize: 24.0)
            case "VISA":
                accountSelected = "VISA 6230"
                changeBtnFont(button: visaBtn, fontName: "HelveticaNeue-Bold", fontSize: 24.0)
            default:
                accountSelected = "Autres"
                changeBtnFont(button: othersBtn, fontName: "HelveticaNeue-Bold", fontSize: 24.0)
            }
        } else { // Previous or Next pressed
            
        }
        
        // Update data
        transactions = loadTransactionsInAccountWithMonthAndYear(accountName: accountSelected, month: monthSelected, year: yearSelected)
        transactionsTV.reloadData()

        // Update Title
        navigationItem.title = accountSelected + " - " + monthShortNames[monthSelected - 1] + " " + String(yearSelected)
    }
    
    //MARK: - Manage Swipeable Cells
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let reccurent = setToReccurent(at: indexPath)
        return UISwipeActionsConfiguration(actions: [reccurent])
    }
    
    // Set to reccurent
    func setToReccurent(at indexPath: IndexPath) -> UIContextualAction {
        let currentTransaction = transactions![indexPath.row]
        let title = currentTransaction.reccurent ? "Pas reccurent" : "Reccurent"
        let color = currentTransaction.reccurent ? UIColor.flatWatermelon : UIColor.flatMint
        
        let action = UIContextualAction(style: .normal, title: title) { (action, view, completion) in
            changeReccurence(of: currentTransaction)
            DispatchQueue.main.async {
                self.transactionsTV.reloadData()
            }
            completion(true)
        }
        action.backgroundColor = color
        return action
    }
}

extension TransactionsVC: UIDocumentPickerDelegate {
    
    // Callback when File Picked
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        // Read file
        do {
            let text = try String(contentsOf: selectedFileURL, encoding: .utf8)

            print(text)

            let doc: Document = try SwiftSoup.parse(text)
            
            let lines: Elements = try doc.select("tr")
            
            for line in lines {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let dateFromFile = try line.select("td:nth-child(1)").text()
                print(dateFromFile)
                guard let date = dateFormatter.date(from: dateFromFile) else { continue }
                let title = try line.select("td:nth-child(2)").text()
                let outcome = try line.select("td:nth-child(3)").text()
                let income = try line.select("td:nth-child(4)").text()
                let amount = Float(income) - Float(outcome)
                
                let newTransaction = Transaction()
                newTransaction.date = date
                newTransaction.title = title
                newTransaction.amount = amount
                saveTransaction(newTransaction)
                
                // Save Category in list
                let selectedCategory = categories!.first
                setCategoryOfTransaction(category: selectedCategory!, transaction: newTransaction)
                
                // Save Account in list
                let selectedAccount = accounts!.first
                setAccountOfTransaction(account: selectedAccount!, transaction: newTransaction)
            }
            
//            let dates: Elements = try doc.select("tr td:nth-child(1)")
//            let titles: Elements = try doc.select("tr td:nth-child(2)")
//            let amountIn: Elements = try doc.select("tr td:nth-child(3)")
//            let amountOut: Elements = try doc.select("tr td:nth-child(4)")
//
//            var i = 0
//            for title in titles {
//                let data = try title.text()
//                print(data)
//            }
            
        }
        catch {
            print("Error: ", error)
        }
        
        
        // Copy in App File System if not already in it
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let sandBoxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
//
//        if FileManager.default.fileExists(atPath: sandBoxFileURL.path) {
//            print("File already exists ! Do nothing")
//        } else {
//            do {
//                try FileManager.default.copyItem(at: selectedFileURL, to: sandBoxFileURL)
//                print("Copied file")
//            } catch {
//                print("Error: ", error)
//            }
//        }

    }
    
    // Function to write Files in Phone
    func writeFile() {
        // Write file to Files dierctory
        let file = "\(UUID().uuidString).txt"
        let contents = "Some text in the file ...."
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("Error: ", error)
        }
    }
    
}


