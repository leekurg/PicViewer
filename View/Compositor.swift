//
//  Compositor.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import UIKit

protocol CompositorProtocol {
    func createMainView() -> UIViewController
//    func createFavoriteView() -> UIViewController
}

class Compositor: CompositorProtocol {
    
    let database = RealmService()
    
    func createMainView() -> UIViewController {
        let view = MainViewController()
        view.databaseService = database
        
        return view
    }
    
//    func createFavoriteView() -> UIViewController {
////        let view = FavoriteImagesViewController()
////        let view = FavoritesCollectionViewController()
//        let view = FavoritesCollectionViewController( collectionViewLayout: UICollectionViewFlowLayout() )  //из видоса
//
//        return view
//    }
}
