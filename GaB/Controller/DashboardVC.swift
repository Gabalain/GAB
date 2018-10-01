//
//  DashboardVC.swift
//  GaB
//
//  Created by Alain Gabellier on 01/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addAccountPressed(_ sender: Any) {
        let modalViewController = NewAccountVC()
        modalViewController.modalPresentationStyle = .overCurrentContext
        present(modalViewController, animated: true, completion: nil)
    }
    
    @IBAction func addCategoryPressed(_ sender: Any) {
    }
}
