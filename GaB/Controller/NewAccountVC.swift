//
//  NewAccountVC.swift
//  GaB
//
//  Created by Alain Gabellier on 01/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class NewAccountVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelBtn(_ sender: Any) {
    }
    @IBAction func saveBtn(_ sender: Any) {
    }
}
