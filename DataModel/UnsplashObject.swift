//
//  UnsplashObject.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import RealmSwift

final class UnsplashObject: Object {
    @objc dynamic var id = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
    @objc dynamic var color = ""
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var downloads = 0
    @objc dynamic var likes = 0
    @objc dynamic var defaultUrl:String?
    @objc dynamic var user = ""
}

extension UnsplashPhoto: Persistable {
    func managedObject() -> UnsplashObject {
        let character = UnsplashObject()
        character.id = id
        character.width = width
        character.height = height
        character.color = color
        character.created_at = created_at
        character.updated_at = updated_at
        character.downloads = downloads
        character.likes = likes
        character.defaultUrl = urls.regular
        if let _user = user {
            character.user = _user.name
        }
        return character
    }
    
    init(managedObject: UnsplashObject) {
        id = managedObject.id
        width = managedObject.width
        height = managedObject.height
        color = managedObject.color
        created_at = managedObject.created_at
        updated_at = managedObject.updated_at
        downloads = managedObject.downloads
        likes = managedObject.likes
        if let defaultUrl = managedObject.defaultUrl{
            urls = ImageUrls( regular: defaultUrl)
        }
        else {
            urls = ImageUrls( regular: "" )
        }
        user = ImageOwnerInfo(name: managedObject.user)
    }
}





public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
