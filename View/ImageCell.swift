//
//  ImageCell.swift
//  PicViewer
//
//  Created by Ильяяя on 21.05.2022.
//

import UIKit
import SDWebImage
import SnapKit

class ImageCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCell"
    
    private let markSelected: UILabel = {
        let label = UILabel()
        label.text = "✔️"
        label.alpha = 0
        return label
    }()
    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10.0
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto? {
        didSet {
            guard let photoUrl = unsplashPhoto?.urls["regular"],
                  let url = URL(string: photoUrl)
            else { return }
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
   
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.5 : 1
        markSelected.alpha = isSelected ? 1 : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedState()
        setupPhotoImageView()
        setupCheckmarkView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCheckmarkView() {
        addSubview(markSelected)
        markSelected.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
