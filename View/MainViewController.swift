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
    private let networkDataParser: NetworkDataParser = NetworkDataParser()
    private let imageView = ImageView()
    private let imageDesc = ImageDesc()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 217/254, green: 215/255, blue: 184/255, alpha: 1)
        
        setupNavigationBar()
        setupView()
        
        setupImage()
    }
    
    // MARK: - setup UI
    
    private func setupView()
    {
//        let imageView: UIView = {
//            let image = UIView()
//            image.backgroundColor = .red
//
//            return image
//        }()
        imageDesc.titleLabel = UILabel()
        imageDesc.descLabel = UILabel()
        
        let addToFavoritesButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.setTitle("❤️", for: .normal)
            
            return button
        }()
        
        view.addSubview(imageView)
        view.addSubview(imageDesc.created())
        view.addSubview(addToFavoritesButton)
        
        //constraints
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
        
        imageDesc.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).inset(-40)
            make.height.equalTo(100)
        }

        addToFavoritesButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(20)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
//            make.bottom.equalToSuperview().inset(30)
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
        let alert = UIAlertController(title: "", message: "Добавлено в избранное", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func willOpenFavoriteImages() {
        navigationController?.pushViewController(FavoritesCollectionViewController( collectionViewLayout: UICollectionViewFlowLayout() ), animated: true)
    }
}

    // MARK: - Image processing

extension MainViewController
{
    private func setupImage()
    {
        self.networkDataParser.fetchImage {[weak self] (unsplashPhotoResult, error) in
            if let error = error{
                self?.handleError(error: error)
            }
            else{
                self?.handleSuccess(unsplashPhoto: unsplashPhotoResult)
            }
        }
    }
    
    private func handleSuccess(unsplashPhoto:UnsplashPhoto?)
    {
//        imageSetupTimerLabel.isError = false
//        navigationsButtonsIsHidden = false
        
        imageDesc.unsplashPhoto = unsplashPhoto
        imageView.unsplashPhoto = unsplashPhoto
        
//        guard let unsplashPhoto = unsplashPhoto else {return}
//        defaults.set(unsplashPhoto.id,forKey: UnsplashPhotoKeys.keyId.rawValue)
//        defaults.set(unsplashPhoto.likes,forKey: UnsplashPhotoKeys.keyLikes.rawValue)
//        defaults.set(unsplashPhoto.downloads,forKey: UnsplashPhotoKeys.keyDownloads.rawValue)
//        defaults.set(unsplashPhoto.urls["regular"],forKey: UnsplashPhotoKeys.keyUrl.rawValue)
    }
    
    private func handleError(error:String){
//        if isHidden {return}
        showErrorPopup(error: error)
//        imageSetupTimerLabel.isError = true
//        navigationsButtonsIsHidden = true
        
//        guard let id = defaults.object(forKey: UnsplashPhotoKeys.keyId.rawValue) as? String,
//              let likes = defaults.object(forKey: UnsplashPhotoKeys.keyLikes.rawValue) as? Int,
//              let downloads = defaults.object(forKey: UnsplashPhotoKeys.keyDownloads.rawValue) as? Int,
//              let url = defaults.object(forKey: UnsplashPhotoKeys.keyUrl.rawValue) as? String
//        else{
//            return
//        }
        
//        let unsplashPhoto = UnsplashPhoto(id: id, width: 0, height: 0, color: "", created_at: "", updated_at: "", downloads: downloads, likes: likes, urls: [UnsplashPhoto.URLSizes.regular.rawValue: url])
        

//        descriptionImageView.unsplashPhoto = unsplashPhoto
//        imageView.unsplashPhoto = unsplashPhoto

    }
    
    
    private func showErrorPopup(error:String){
//        SwiftEntryKit.display(entry: PopUpView(with: error), using: EKAttributes.topToast)
    }
}
