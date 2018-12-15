//
//  profileVC.swift
//  smack
//
//  Created by tarek bahie on 12/12/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class profileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
//
    }

    func setUpView(){
                profileImg.image = UIImage(named: UserDataService.instance.avatarName)
                profileImg.backgroundColor = UserDataService.instance.returnUIColor(Components: UserDataService.instance.avatarColor)
                userName.text = UserDataService.instance.name
                userEmail.text = UserDataService.instance.email
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(profileVC.closeTap( _:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    @objc func closeTap( _ recognizer : UIGestureRecognizer ){
        dismiss(animated: true, completion: nil)
    }



    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func logOutPressed(_ sender: Any) {
        UserDataService.instance.logOutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    




}
