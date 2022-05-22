//
//  ImageView.swift
//  PicViewer
//
//  Created by Ильяяя on 20.05.2022.
//

import UIKit
import SDWebImage

class ImageView: UIImageView {

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
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
