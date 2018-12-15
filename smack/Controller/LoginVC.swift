//
//  LoginVC.swift
//  smack
//
//  Created by tarek bahie on 12/8/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: ColorPlaceHolder!
    @IBOutlet weak var passwordTxt: ColorPlaceHolder!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        handleTap()
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAcoountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_Create, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let email  = usernameTxt.text , usernameTxt.text != "" else {
            return
        }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {
            return
        }
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success{
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    
    
}
