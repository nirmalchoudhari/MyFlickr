//
//  SearchResult.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

struct Photo: Codable {
    var id: String
    var owner: String
    var secret: String
    var title: String
    var server: String
    var farm: Int

    func urlString() -> String {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
