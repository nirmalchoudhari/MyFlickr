//
//  Photos.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

struct Photos: Codable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var photo: [Photo]
}
