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


let TO_LOGIN = "toLogin"
let TO_Create = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

let HEADER =  ["Content-Type": "application/json; charsetutf=8"
]
