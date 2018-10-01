//
//  RealmManagement.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

// Init REALM
let realm = try! Realm()

//MARK: - Transactions actions
func loadTransactions() -> Results<Transaction> {
    return realm.objects(Transaction.self)
}

func loadTransactionsInAccount(_ accountName: String)  -> Results<Transaction> {
    // Find Account with this name
    let predicate1 = NSPredicate(format: "name == %@", accountName)
    let account = realm.objects(Account.self).filter(predicate1).first ?? realm.objects(Account.self).first!
    // Query using an NSPredicate    
    let predicate2 = NSPredicate(format: "ANY account = %@", account)
    print(predicate2)
    return realm.objects(Transaction.self).filter(predicate2)
}

func loadTransactionsInAccountWithMonthAndYear(accountName: String, month: Int, year: Int)  -> Results<Transaction> {
    // Query using an NSPredicate
    var components = DateComponents()
    components.day = 1
    components.month = month
    components.year = year
    var startDate = Calendar.current.date(from: components)
    components.day = 0
    components.month = 0
    components.year = 0
    components.hour = 14
    startDate = Calendar.current.date(byAdding: components, to: startDate!)
    print(month, year, startDate!)
    
    //Now create endDateOfMonth using startDateOfMonth
    components.year = 0
    components.month = 1
    components.day = -1
    components.hour = 0
    let endDate = Calendar.current.date(byAdding: components, to: startDate!)
    print(month, year, endDate!)
    
    // Find Account with name accountName
    let predicate1 = NSPredicate(format: "name == %@", accountName)
    let account = realm.objects(Account.self).filter(predicate1).first ?? realm.objects(Account.self).first!

    let predicate = NSPredicate(format: "ANY account == %@ AND date >= %@ AND date <= %@", account, startDate! as CVarArg, endDate! as CVarArg)
    
    print(predicate)
    return realm.objects(Transaction.self).filter(predicate)
}

//func deleteTransaction(at index: Int) {
//    let transactions = loadTransactions()
//    let transactionForDeletion = transactions[index]
//    do {
//        try realm.write {
//            realm.delete(transactionForDeletion)
//        }
//    } catch {
//        print("Error deleting transaction, \(error)")
//    }
//}

//MARK: - Categories actions
func loadCategories() -> Results<Category> {
    return realm.objects(Category.self)
}

func setCategoryOfTransaction(category: Category, transaction: Transaction) {
    do {
        try realm.write {
            category.transactions.append(transaction)
        }
    } catch {
        print("Error setting category of Transaction ------------------------")
        debugPrint(error)
    }
}

func getCategoryColor(_ categoryName: String) -> String {
    let predicate = NSPredicate(format: "name == %@", categoryName)
    return realm.objects(Category.self).filter(predicate).first?.color ?? "98a5a6"
}
//func deleteCategory(at index: Int) {
//    let categories = loadCategories()
//    let categoryForDeletion = categories[index]
//    do {
//        try realm.write {
//            realm.delete(categoryForDeletion)
//        }
//    } catch {
//        print("Error deleting category, \(error)")
//    }
//}

//MARK: - Accounts actions
func loadAccounts() -> Results<Account> {
    return realm.objects(Account.self)
}

func setAccountOfTransaction(account: Account, transaction: Transaction) {
    do {
        try realm.write {
            account.transactions.append(transaction)
        }
    } catch {
        print("Error setting account of Transaction ------------------------")
        debugPrint(error)
    }
}

func getAccountSelected(_ accountName: String) -> Account {
    let predicate = NSPredicate(format: "name == %@", accountName)
    return realm.objects(Account.self).filter(predicate).first ?? realm.objects(Account.self).first!
}
//func deleteAccount(at index: Int) {
//    let accounts = loadAccounts()
//    let accountForDeletion = accounts[index]
//    do {
//        try realm.write {
//            realm.delete(accountForDeletion)
//        }
//    } catch {
//        print("Error deleting account, \(error)")
//    }
//}

//MARK: Save data
func changeReccurence(of transaction: Transaction) {
    try! realm.write {
        transaction.reccurent = !transaction.reccurent
    }
}

func saveTransaction(_ transaction: Transaction) {
    print("Save Transaction started")
    do { try realm.write {
        realm.add(transaction)
        }
    } catch {
        print("Error saving transaction \(error)")
    }
}

func saveCategory(_ category: Category) {
    let realm = try! Realm()
    print("Save Category started: " + category.name)
    do { try realm.write {
        realm.add(category)
        }
    } catch {
        print("Error saving category \(error)")
    }
}

func saveAccount(_ account: Account) {
    print("Save Account started")
    do { try realm.write {
        realm.add(account)
        }
    } catch {
        print("Error saving account \(error)")
    }
}

func resetTransactions() {
    let transactions = loadTransactions()
    do {
        try realm.write {
            realm.delete(transactions)
            
        }
    } catch {
        print("Error deleting transaction, \(error)")
    }
}

