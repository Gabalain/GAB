//
//  ViewController.swift
//  GaB
//
//  Created by Alain Gabellier on 26/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionsVC: UIViewController {
    
    @IBOutlet weak var transactionsTV: UITableView!
    
    var transactions: Results<Transaction>?
    var categories: Results<Category>?
    var accounts: Results<Account>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Supposed to turn Status bar to white !!!
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        transactionsTV.delegate = self
        transactionsTV.dataSource = self
        
        transactions = loadTransactions()
        categories = loadCategories()
        accounts = loadAccounts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let transactions = transactions else { return 1 }
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = transactionsTV.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionCell else { return TransactionCell() }
        cell.configureCell(withTransaction: transactions![indexPath.row], atIndex: indexPath.row)
        return cell
    }
    
}

