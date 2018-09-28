//
//  Transactions.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class Transaction : Object {
    
    // Properties
    @objc dynamic var date: Date = Date()
    @objc dynamic var title: String = ""
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var reccurent: Bool = false
    var category = LinkingObjects(fromType: Category.self, property: "transactions")
    var account = LinkingObjects(fromType: Account.self, property: "transactions")
}
