//
//  TransitionViewController.swift
//  PicViewer
//
//  Created by Ильяяя on 18.05.2022.
//

import Foundation
import UIKit
import SnapKit

class TransitionViewController: UINavigationController {
    
    
    
    
    private lazy var toFavButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showFavoritesView), for: .touchUpInside)
        button.setTitle("Favorites", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
        button.layer.cornerRadius = 20

        return button
    }()
    
    
    
    var favorites: FavoritesCollectionViewController { FavoritesCollectionViewController(collectionViewLayout: UICollectionViewLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(toFavButton)
        toFavButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
    }
    
    @objc private func showFavoritesView()
    {
        print(#function)
        pushViewController(favorites, animated: true)
        
        if !toFavButton.isHidden
        {
            toFavButton.isHidden = true
        }
    }
    
    
}
