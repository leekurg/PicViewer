//
//  FavoritesCollectionViewController.swift
//  PicViewer
//
//  Created by Ильяяя on 17.05.2022.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {

    var networkDataParser = NetworkDataParser()
//    private var timer: Timer?
    var databaseService:DatabaseService?

    private var imagesModel:[UnsplashPhoto?] = []

    private var selectedImages = [UIImage]()

    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeImageButtonTapped))
    }()


    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }

    // MARK: - View Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let objects = databaseService?.objects(){
            imagesModel = objects
        }
        self.collectionView.reloadData()
        self.refresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        undateNavButtonsState()
        collectionView.backgroundColor = UIColor(red: 217/254, green: 215/255, blue: 184/255, alpha: 1)
        setupNavigationBar()
        setupCollectionView()
    }

    private func undateNavButtonsState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }

    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        undateNavButtonsState()
    }

    // MARK: - NavigationItems action

    @objc private func removeImageButtonTapped() {

        let indexPaths = collectionView!.indexPathsForSelectedItems!

        self.databaseService?.remove(indexPaths)
        if let objects = databaseService?.objects(){
            imagesModel = objects
        }

        self.collectionView!.performBatchUpdates({
            self.collectionView!.deleteItems(at: indexPaths)
        }, completion: nil)
        
        refresh()
    }


    // MARK: - Setup UI Elements

    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)

        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [addBarButtonItem]
    }



    // MARK: - UICollecionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print( "Favorites count: \(imagesModel.count) ")
        return imagesModel.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
        let unsplashPhoto = imagesModel[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        guard let image = cell.photoImageView.image else { return }
            selectedImages.append(image)
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        guard let image = cell.photoImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let image = imagesModel[indexPath.item] else {return CGSize()}
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(image.height) * widthPerItem / CGFloat(image.width)
        return CGSize(width: widthPerItem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
