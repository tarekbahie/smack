//
//  ChannelCell.swift
//  smack
//
//  Created by tarek bahie on 12/15/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }

    }

    func configureCell(channel : C){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MassageService.instance.unreadChannels {
            if id == channel.channelId{
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            }
        }
        
    }
}
