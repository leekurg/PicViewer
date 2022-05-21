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
    private let userDefaults = UserDefaults.standard
    private let imageView = ImageView()
    private let imageDesc = ImageDesc()
    private let favoritesView = FavoritesCollectionViewController( collectionViewLayout: UICollectionViewFlowLayout() )
    private let addToFavoritesButton = UIButton(type: .system)
    
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
        imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10.0
        imageView.clipsToBounds = false
        
        imageDesc.titleLabel = UILabel()
        imageDesc.descLabel = UILabel()
        
        addToFavoritesButton.setBackgroundColor(color: UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1), forState: .normal)
//        addToFavoritesButton.setBackgroundColor(color: .lightGray, forState: .disabled)
        addToFavoritesButton.setTitleColor(.white, for: .normal)
        addToFavoritesButton.layer.cornerRadius = 20
        addToFavoritesButton.setTitle("🤍", for: .normal)
        addToFavoritesButton.setTitle("❤️", for: .disabled)
        addToFavoritesButton.isUserInteractionEnabled = false   //для обработки старта без сети
        
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
        }
        
        //actions
        addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar()
    {
        let favoriteButton = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(willOpenFavoriteImages))
        self.navigationItem.rightBarButtonItem = favoriteButton
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(nextImage))
        self.navigationItem.leftBarButtonItem = refreshButton
        
//        self.navigationItem.titleView = timerLabel
//        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    }
    
    // MARK: - Navigation action
    
    @objc private func addToFavoritesTapped()
    {
        print(#function)

        databaseService?.write(imageView.unsplashPhoto)
        addToFavoritesButton.isEnabled = false
        
        let alert = UIAlertController(title: "", message: "Added to Favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func willOpenFavoriteImages() {
        navigationController?.pushViewController(favoritesView, animated: true)
    }
    
    @objc func nextImage() {
        setupImage()
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
        
        addToFavoritesButton.isUserInteractionEnabled = true
        addToFavoritesButton.isEnabled = true
        
        imageDesc.unsplashPhoto = unsplashPhoto
        imageView.unsplashPhoto = unsplashPhoto
        
        guard let unsplashPhoto = unsplashPhoto else {return}
        userDefaults.set(unsplashPhoto.id,forKey: UnsplashPhotoKeys.keyId.rawValue)
        userDefaults.set(unsplashPhoto.created_at,forKey: UnsplashPhotoKeys.keyCreated.rawValue)
        userDefaults.set(unsplashPhoto.urls["regular"],forKey: UnsplashPhotoKeys.keyUrl.rawValue)
    }
    
    private func handleError(error:String){
//        if isHidden {return}
        showErrorPopup(error: error)
//        imageSetupTimerLabel.isError = true
        
            guard let id = userDefaults.object(forKey: UnsplashPhotoKeys.keyId.rawValue) as? String,
                  let created_at = userDefaults.object(forKey: UnsplashPhotoKeys.keyCreated.rawValue) as? String,
                  let url = userDefaults.object(forKey: UnsplashPhotoKeys.keyUrl.rawValue) as? String
            else{
                return
            }
            
            let unsplashPhoto = UnsplashPhoto(id: id, width: 0, height: 0, color: "", created_at: created_at, updated_at: "", downloads: 0, likes: 0, urls: [UnsplashPhoto.URLSizes.regular.rawValue: url])
        

        imageView.unsplashPhoto = unsplashPhoto
        imageDesc.unsplashPhoto = unsplashPhoto

    }
    
    
    private func showErrorPopup(error:String){
        let alert = UIAlertController(title: "", message: "❗️" + error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - Database setup
extension MainViewController {
    
    func setDatabase( db: RealmService ) {
        databaseService = db
        favoritesView.databaseService = db
    }
}

// MARK: - UIButton extention for states

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

