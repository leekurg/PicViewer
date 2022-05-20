//
//  FavoritesCollectionViewController.swift
//  PicViewer
//
//  Created by Ильяяя on 17.05.2022.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .green
//        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)

        cell.backgroundColor = .red
        return cell
    }
    
    
    // MARK: - Navigation
    
    private func setupCollectionView()
    {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }
    
//    private func setupNavigationBar()
//    {
//        let titleLabel = UILabel()
//        titleLabel.text = "Favorites"
//        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
//        titleLabel.textColor = .gray
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem( customView: titleLabel )
//
//
//    }
}
