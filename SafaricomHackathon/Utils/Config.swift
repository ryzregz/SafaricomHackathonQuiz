//
//  Config.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
import UIKit
class Config{
  public var APIKEY = ""
  public var BASEURL = ""
  public var COUNTRY = ""
    
    
    var mainColor = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1.0)
    class var sharedManager: Config {
        struct Static {
            static let instance = Config()
        }
        return Static.instance
    }
    
    init(){
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "config", ofType: "plist")!)) else{
            return
        }
        do {
            let decoder = PropertyListDecoder()
            let config = try decoder.decode(ConfigParams.self, from: data)
            BASEURL = config.baseURL
            APIKEY = config.apiKey
            COUNTRY = config.country
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}


class ConfigParams: Codable{
    var baseURL:String
    var apiKey:String
    var country:String
    private enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case apiKey = "api_key"
        case country = "country"
    }
}
