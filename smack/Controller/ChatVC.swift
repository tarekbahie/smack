//
//  ChatVC.swift
//  smack
//
//  Created by tarek bahie on 12/7/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MassageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    

    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTxtLbl: ColorPlaceHolder!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingLbl: UILabel!
    
    
    
    
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        sendBtn.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        handleTap()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MassageService.instance.selectedChannel?.channelId && AuthService.instance.isLoggedIn{
                MassageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MassageService.instance.messages.count > 0{
                    let endIndex = IndexPath(row: MassageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MassageService.instance.selectedChannel?.channelId else{return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers{
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                    var verb = "is"
                if numberOfTypers > 1{
                    verb = "are"
                }
                self.typingLbl.text = "\(names) \(verb) typing a message"
            }else {
                self.typingLbl.text = ""
            }
        }
        
        
            
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
            tableView.reloadData()
            
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
            if success{
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    @IBAction func messageEditing(_ sender: Any) {
        guard let channelId = MassageService.instance.selectedChannel?.channelId else{return}
        if messageTxtLbl.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId )
            
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true

        }
    }
    
    
    
    
    
    
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MassageService.instance.selectedChannel?.channelId else{return}
            guard let message = messageTxtLbl.text else{return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success{
                    self.messageTxtLbl.text = ""
                    self.messageTxtLbl.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType",UserDataService.instance.name, channelId )
                    
                }
            }
        }
        
    }
    
}
