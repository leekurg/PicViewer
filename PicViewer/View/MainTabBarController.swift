//
//  MainTabBarController.swift
//  PicViewer
//
//  Created by Ильяяя on 17.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let database = RealmDatabaseService()
        
        let favoritesPhotos = FavoritesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        favoritesPhotos.setupDatabaseService(database)
        let exploreView = /*ExploreViewConroller()*/MainViewController()
//        exploreView.setupDatabaseService(database)
        
        viewControllers = [
            createNavigationController(rootViewController: exploreView, title: "Photos"/*, image: #imageLiteral(resourceName: "photos")*/),
            createNavigationController(rootViewController: favoritesPhotos, title: "Favourites"/*, image: #imageLiteral(resourceName: "heart")*/)
        ]
    }
    

    
    private func createNavigationController(rootViewController: UIViewController, title: String/*, image: UIImage*/) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
//        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
