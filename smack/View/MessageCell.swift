//
//  MessageCell.swift
//  smack
//
//  Created by tarek bahie on 12/16/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageTxtLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(message : Message){
        messageTxtLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(Components: message.userAvatarColor)
    }




}
