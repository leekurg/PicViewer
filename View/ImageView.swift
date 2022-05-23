//
//  ImageView.swift
//  PicViewer
//
//  Created by Ильяяя on 20.05.2022.
//

import UIKit
import SDWebImage

class ImageView: UIImageView {

    private var imageSize: CGSize?
    private let imageMaxHeight: CGFloat = 580
    
    var unsplashPhoto:UnsplashPhoto?{
        didSet{
            let photoUrl = unsplashPhoto?.urls.regular
            DispatchQueue.global().async {
                guard let photoUrl = photoUrl, let url = URL(string: photoUrl) else {return}
                DispatchQueue.main.async {
                    self.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
    
    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
//        clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            var scaledHeight = myImageHeight * ratio
            
            if scaledHeight > imageMaxHeight {
                scaledHeight = imageMaxHeight
            }
            
            imageSize = CGSize(width: myViewWidth, height: scaledHeight)
            return imageSize!
        }
        
        if let _ = imageSize {
            return imageSize!
        }
        else {
            return CGSize(width: -1.0, height: -1.0)
        }
    }
}
