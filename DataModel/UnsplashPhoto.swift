//
//  UnsplashPhoto.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import RealmSwift

struct UnsplashPhoto: Codable{
    let id: String
    let width: Int
    let height: Int
    let color: String
    let created_at:String
    let updated_at:String
    let downloads:Int
    let likes:Int
    let urls: ImageUrls
    let user: ImageOwnerInfo?
}

struct ImageUrls: Codable {
    var regular: String
}

struct ImageOwnerInfo: Codable {
    let name: String
}

enum UnsplashPhotoKeys: String{
    case keyId = "id"
    case keyLikes = "likes"
    case keyDownloads = "downloads"
    case keyUrl = "url"
    case keyCreated = "created_at"
    case keyUserName = "author"
}
