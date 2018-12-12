//
//  ChannelVC.swift
//  smack
//
//  Created by tarek bahie on 12/7/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue){}
    
    @IBOutlet weak var userImg: CircleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60.0
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
   @objc func userDataDidChange(_ notif : Notification){
    if AuthService.instance.isLoggedIn{
        loginBtn.setTitle(UserDataService.instance.name, for: .normal)
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(Components: UserDataService.instance.avatarColor)
        
    }else {
        loginBtn.setTitle("Login", for: .normal)
        userImg.image = UIImage(named: "menuProfileIcon")
        userImg.backgroundColor = UIColor.clear
    }
        
    }
}
