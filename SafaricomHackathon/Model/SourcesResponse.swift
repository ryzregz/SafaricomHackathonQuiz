//
//  SourcesResponse.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
class SourcesResponse : Codable{
    public var status: String
    public var sources : [Source]?
    
    enum CodingKeys : String, CodingKey{
        case status
        case sources
    }
    
    required public init(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        sources = try container.decodeIfPresent([Source].self, forKey: .sources) ?? nil
        
    }
    
    public func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(sources, forKey: .sources)
    }
}
