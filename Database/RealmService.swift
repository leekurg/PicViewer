//
//  RealmService.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//


import Foundation
import RealmSwift



final class RealmService: DatabaseService{
    
    
    private var _objects: Results<UnsplashObject>!
    func objects() -> [UnsplashPhoto?] {
        return _objects.map({ UnsplashPhoto(managedObject: $0)})
    }
    
    
    private let realm:Realm = try! Realm()
        
    func updateObjects(){
        _objects = realm.objects(UnsplashObject.self)
    }
    init(){
        updateObjects()
    }
    
    func write(_ object:UnsplashPhoto?){
        guard let unsplashObject = object else {return}
        try! realm.write({
            if let object = convertInputObject(unsplashObject){
                realm.add(object)
            }
        })
        
        updateObjects()
    }
 
    func remove(_ indexPaths:[IndexPath]) {
        
        let indexes = indexPaths.map { item in
            item.item
        }
        var newImages = [UnsplashObject]()
        for (index, image) in _objects.enumerated() {
            if indexes.contains(index){
                newImages.append(image)
            }
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(newImages)
        }
    }
    
    private func convertInputObject(_ object:UnsplashPhoto) -> Object? {
        return object.managedObject()
    }
}
