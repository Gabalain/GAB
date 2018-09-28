//
//  Accounts.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class Account: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var image : String = ""
    let transactions = List<Transaction>()
}
