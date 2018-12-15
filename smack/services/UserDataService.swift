//
//  UserDataService.swift
//  smack
//
//  Created by tarek bahie on 12/10/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    func setUserData(id : String, color : String, avatarName: String, email : String, name : String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName : String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(Components : String) -> UIColor{
        
        let scanner = Scanner(string: Components)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let unwrappedR = r else {return defaultColor }
        guard let unwrappedG = g else {return defaultColor }
        guard let unwrappedB = b else {return defaultColor }
        guard let unwrappedA = a else {return defaultColor }
        
        let rFloat = CGFloat(unwrappedR.doubleValue)
        let gFloat = CGFloat(unwrappedG.doubleValue)
        let bFloat = CGFloat(unwrappedB.doubleValue)
        let aFloat = CGFloat(unwrappedA.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        
        
        return newUIColor
    }

    func logOutUser(){
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        MassageService.instance.clearChannels()
    }


}
