//
//  ChannelVC.swift
//  smack
//
//  Created by tarek bahie on 12/7/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue){}
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userImg: CircleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60.0
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        SocketService.instance.getChannel { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }
    
    @IBAction func addChanelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
        let addChannel = AddChannelVc()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
        
    }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = profileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        }else{
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    }
   @objc func userDataDidChange(_ notif : Notification){
        setUpUserInfo()
        
    }
    @objc func channelsLoaded(_ notif : Notification){
        tableView.reloadData()
        
    }
    
    
    
    func setUpUserInfo(){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(Components: UserDataService.instance.avatarColor)
            
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell" , for: indexPath) as? ChannelCell{
            let channel = MassageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MassageService.instance.channels[indexPath.row]
        MassageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    
    
}
