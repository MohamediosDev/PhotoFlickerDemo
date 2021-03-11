//
//  PhotosModel.swift
//  FlickerSearch
//
//  Created by Mohamed on 3/10/21.

import Foundation

// MARK: - PhotosModal
struct PhotosModal: Codable {
    var photos: Photos?
}

// MARK: - Photos
struct Photos: Codable {
    var page, pages, perpage: Int?
    var total: String?
    var photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    var id, owner, secret, server: String?
    var farm: Int?
    var title: String?
    var ispublic, isfriend, isfamily: Int?
    var urlM: String?
    var heightM, widthM: Int?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlM = "url_m"
        case heightM = "height_m"
        case widthM = "width_m"
    }
}
