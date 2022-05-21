//
//  ImageDesc.swift
//  PicViewer
//
//  Created by Ильяяя on 20.05.2022.
//

import UIKit

class ImageDesc: UIView {
    
    var titleLabel: UILabel!
    var descLabel: UILabel!
    
    var unsplashPhoto:UnsplashPhoto?{
        didSet{
            guard let unsplashPhoto = self.unsplashPhoto else {
                hide()
                return
            }
            show()
            
            if let label = descLabel {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd.MM.yyyy"

                let date = dateFormatterGet.date(from: unsplashPhoto.created_at)
                var sDate = ""
                if let d = date {
                    sDate = dateFormatterPrint.string(from: d)
                }
                
//                label.text = "Created at \(sDate) by  \(unsplashPhoto.id)"
                label.text = "Created at \(sDate) by someName"
            }
        }
    }
    
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func created() -> Self {
        configure()

        return self
    }
    
    private func hide(){
        self.isHidden = true
//        layer.borderWidth = 0
    }
    private func show(){
        self.isHidden = false
//        layer.borderWidth = 1
    }
}

// MARK: - Configure UI
private extension ImageDesc {
    func configure() {
        
        if let label = titleLabel {
            addSubview(label)
            label.text = "About photo"
            label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
            label.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
            }
        }
        
        if let label = descLabel {
            addSubview(label)
            label.text = "No description"
            label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
            label.numberOfLines = 0
            label.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom)
            }
        }
    }
}
