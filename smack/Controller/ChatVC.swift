//
//  ChatVC.swift
//  smack
//
//  Created by tarek bahie on 12/7/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var messageTxtBox: ColorPlaceHolder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        handleTap()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
            
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        } )
        }
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func channelSelected(_ notif : Notification){
        updateWithChannel()
    
    
    }
    func updateWithChannel() {
        let channelName = MassageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
        
    }
    
    @objc func userDataDidChange(_ notif : Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
            
        }else{
            channelNameLbl.text = "Please Log In"
            
        }
    
    }
    func onLoginGetMessages(){
        MassageService.instance.finAllChannel { (success) in
            if success{
                if MassageService.instance.channels.count>0{
                    MassageService.instance.selectedChannel = MassageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLbl.text = "No Channels Yet!"
                }
                
                
            }
        }
    }
    func getMessages(){
        guard let channelId = MassageService.instance.selectedChannel?.channelId else{return}
        MassageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MassageService.instance.selectedChannel?.channelId else{return}
            guard let message = messageTxtBox.text else{return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success{
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                }
            }
        }
        
    }
    
}
