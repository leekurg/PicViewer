//
//  UnsplashInfoModel.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation

public struct UnsplashInfoModel: Codable{
    let id: String
    let width: Int
    let height: Int
    let created_at:String
    let urls: ImageUrls
    let user: ImageOwnerInfo?
}

extension UnsplashInfoModel {
    struct ImageUrls: Codable {
        var regular: String
    }
}

extension UnsplashInfoModel {
    struct ImageOwnerInfo: Codable {
        let name: String
    }
}
