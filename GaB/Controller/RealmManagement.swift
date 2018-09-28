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

func loadTransactionsInAccount(_ account: String)  -> Results<Transaction> {
    // Query using an NSPredicate
    let predicate = NSPredicate(format: "account = %@", account)
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
func getCategoryColor(_ categoryName: String) -> String {
    let predicate = NSPredicate(format: "category.name == %@", categoryName)
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

