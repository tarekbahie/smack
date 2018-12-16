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

    func configureCell(message : Message) {
        messageTxtLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(Components: message.userAvatarColor)
        guard var isoDate = message.timeStamp as? String else {
            return
        }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
         isoDate = String(isoDate.prefix(upTo: end))
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate{
            let finalDate = newFormatter.string(from: finalDate)
            timeLbl.text = finalDate
        }
    }




}
