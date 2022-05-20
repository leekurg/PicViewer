//
//  DatabaseService.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import Foundation

protocol DatabaseService{
    func write(_ object:UnsplashPhoto?)
    func objects() -> [UnsplashPhoto?]
    func remove(_ indexPaths:[IndexPath])
    func updateObjects()
}
