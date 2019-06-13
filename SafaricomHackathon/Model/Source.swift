//
//  Source.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
class Source : Codable{
    public var id : String
    public var name : String
    public var description: String?
    public var url : String
    public var category : String
    public var language : String
    public var country : String
    
    enum CodingKeys : String, CodingKey{
        case id
        case name
        case description
        case url
        case category
        case language
        case country
    }
    
    required public init(from decode : Decoder) throws{
        let container = try decode.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try container.decode(String.self, forKey: .url)
        category = try container.decode(String.self, forKey: .category)
        language =  try container.decode(String.self, forKey: .language)
        country =  try container.decode(String.self, forKey: .country)
    }
    
    public func encode(to encode : Encoder) throws{
        var container = encode.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)
        try container.encode(category, forKey: .category)
        try container.encode(language, forKey: .language)
        try container.encode(country, forKey: .country)
    }
    
    
}
