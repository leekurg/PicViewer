//
//  MainViewController.swift
//  PicViewer
//
//  Created by Ильяяя on 17.05.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController
{
     var databaseService: DatabaseService?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        setupNavigationBar()
        setupView()
    }
    
    // MARK: - setup UI
    
//    private func setupNavigationBar()
//    {
//        let titleLabel = UILabel()
//        titleLabel.text = "Photos"
//        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
//        titleLabel.textColor = .gray
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem( customView: titleLabel )
////        navigationItem.rightBarButtonItems = [addButton]
//    }
    
    private func setupView()
    {
//        let imageView: UIImageView = {
//            let image = UIImageView(image: .none)
//            image.contentMode = UIView.ContentMode.scaleAspectFit
//            image.clipsToBounds = true
//
//            return image
//        }()
        let imageView: UIView = {
            let image = UIView()
            image.backgroundColor = .red
 
            return image
        }()
        
        let addToFavoritesButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.setTitle("like", for: .normal)
            
            return button
        }()
        
        view.addSubview(imageView)
        view.addSubview(addToFavoritesButton)
        
        //constraints
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }

        addToFavoritesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(30)
        }
        
        //actions
        addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar()
    {
        let favoriteButton = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(willOpenFavoriteImages))
        self.navigationItem.rightBarButtonItem = favoriteButton
//        self.navigationItem.titleView = timerLabel
//        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    }
    
    // MARK: - Navigation action
    
    @objc private func addToFavoritesTapped()
    {
        print(#function)
    }
    
    @objc func willOpenFavoriteImages() {
        navigationController?.pushViewController(FavoritesCollectionViewController( collectionViewLayout: UICollectionViewFlowLayout() ), animated: true)
    }
}
