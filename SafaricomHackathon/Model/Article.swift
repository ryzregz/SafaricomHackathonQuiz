//
//  Article.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
class Article : Codable{
    public var author : String?
    public var title : String
    public var description : String?
    public var url : String?
    public var urlToImage : String?
    public var publishedAt : String?
    public var content : String?
    
    enum CodingKeys : String, CodingKey{
        case author
        case title
        case description = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    required public init(from decode : Decoder) throws{
        let container = try decode.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        
    }
    
    public func encode(to encoder : Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(content, forKey: .content)
        
    }
}
