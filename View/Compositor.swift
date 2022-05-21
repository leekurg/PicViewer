//
//  Compositor.swift
//  PicViewer
//
//  Created by Ильяяя on 19.05.2022.
//

import UIKit

protocol CompositorProtocol {
    func createMainView() -> UIViewController
}

class Compositor: CompositorProtocol {
    
    let database = RealmService()
    
    
    func createMainView() -> UIViewController {
        let view = MainViewController()
        view.setDatabase(db: database)
        
        return view
    }
}
