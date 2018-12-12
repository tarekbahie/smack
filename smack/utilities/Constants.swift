//
//  Constants.swift
//  smack
//
//  Created by tarek bahie on 12/8/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import Foundation
typealias CompletionHandler = (_ Success: Bool) -> ()

let Base_URL = "https://chattychatchat12323.herokuapp.com/V1/"
let URL_REGISTER = "\(Base_URL)account/register"
let URL_LOGIN = "\(Base_URL)account/login"
let URL_USER_ADD = "\(Base_URL)user/add"


let smackPurplePlaceHolder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)



let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")




let TO_LOGIN = "toLogin"
let TO_Create = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

let HEADER =  ["Content-Type": "application/json; charsetutf=8"
]
