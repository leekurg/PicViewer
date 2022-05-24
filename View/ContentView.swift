//
//  ContentView.swift
//  PicViewer
//
//  Created by Ильяяя on 23.05.2022.
//

import UIKit
import SnapKit

class ContentView: UIView {

    var imageView: ImageView!
    var imageDesc: ImageDesc!
    
    func setupView() {
        imageView = ImageView()
        imageDesc = ImageDesc()
        
        imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10.0
        imageView.clipsToBounds = false
        
        imageDesc.titleLabel = UILabel()
        imageDesc.descLabel = UILabel()
        
        addSubview(imageView)
        addSubview(imageDesc.created())
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        imageDesc.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).inset(-40)
            make.height.equalTo(100)    //TODO is nesessary?
        }
    }
}
