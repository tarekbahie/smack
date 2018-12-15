//
//  AddChannelVc.swift
//  smack
//
//  Created by tarek bahie on 12/15/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class AddChannelVc: UIViewController {

    @IBOutlet weak var nameTxt: ColorPlaceHolder!
    
    @IBOutlet weak var chanDesc: ColorPlaceHolder!
    
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        

    }

    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName  = nameTxt.text , nameTxt.text != "" else {
            return
        }
        guard let channelDescription = chanDesc.text else {
            return
        }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVc.closeTap( _:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    @objc func closeTap( _ recognizer : UITapGestureRecognizer ){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
