//
//  Response.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
class Response : Codable{
    public var status: String
    public var totalResults : Int?
    public var articles : [Article]?
    
    enum CodingKeys : String, CodingKey{
        case status
        case totalResults
        case articles
    }
    
    required public init(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        articles = try container.decode([Article].self, forKey: .articles)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? nil
        
    }
    
    public func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(articles, forKey: .articles)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
}
