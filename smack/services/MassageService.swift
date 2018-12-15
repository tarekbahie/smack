//
//  MessageService.swift
//  smack
//
//  Created by tarek bahie on 12/15/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MassageService {
    static let instance = MassageService()
    
    var channels = [C]()
    var selectedChannel : C?
    
    func finAllChannel(completion : @escaping CompletionHandler ){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER ).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{return}
                if let json = try! JSON(data : data).array {
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = C(channelTitle : name, channelDiscription : channelDescription, channelId : id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func clearChannels(){
        channels.removeAll()
    }
    
}
