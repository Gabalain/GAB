//
//  TransactionCell.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import ChameleonFramework

class TransactionCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var reccurentLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withTransaction transaction: Transaction, atIndex index: Int) {
        titleLbl.text = transaction.title
        amountLbl.text = floatToString(transaction.amount, 2) + "€"
        dateLbl.text = dateToString(transaction.date, "dd-MM")
        if transaction.reccurent {
            reccurentLbl.backgroundColor = UIColor.flatRed
        } else {
            reccurentLbl.backgroundColor = UIColor(white: 1, alpha: 0)
        }
        
        if index % 2 == 0 { self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.200395976) }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
