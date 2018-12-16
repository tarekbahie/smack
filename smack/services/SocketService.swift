//
//  SocketService.swift
//  smack
//
//  Created by tarek bahie on 12/15/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService ()
    
    override init() {
        super.init()
    }
    let manager = SocketManager(socketURL: URL(string: Base_URL)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func addChannel(channelName : String, channelDescription : String, completion : @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
}
    func getChannel(completion : @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else{return}
            guard let channelDescription = dataArray[1] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            let newChannel = C(channelTitle : channelName, channelDiscription : channelDescription, channelId : channelId)
            MassageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    func addMessage(messageBody : String, userId : String, channelId : String, completion : @escaping CompletionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    
    
}
