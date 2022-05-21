//
//  UnsplashPhoto.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import RealmSwift

struct UnsplashPhoto: Decodable, Hashable{
    let id: String
    let width: Int
    let height: Int
    let color: String
    let created_at:String
    let updated_at:String
    let downloads:Int
    let likes:Int
//    let user: String
    let urls:[URLSizes.RawValue:String]
    
    enum URLSizes:String{
        case taw
        case full
        case regular
        case small
        case thumb
    }
}

enum UnsplashPhotoKeys: String{
    case keyId = "id"
    case keyLikes = "likes"
    case keyDownloads = "downloads"
    case keyUrl = "url"
    case keyCreated = "created_at"
//    case keyAuthor = "author"
}
