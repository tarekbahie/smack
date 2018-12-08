//
//  CreateAccountVC.swift
//  smack
//
//  Created by tarek bahie on 12/8/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    

    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
}
