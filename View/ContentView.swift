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

        imageView = {
            let view = ImageView()
            view.layer.shadowOffset = CGSize(width: 0, height: 8)
            view.layer.shadowOpacity = 0.5
            view.layer.shadowRadius = 10.0
            view.clipsToBounds = false
            return view
        }()
            
        imageDesc = {
            let view = ImageDesc()
            view.titleLabel = UILabel()
            view.descLabel = UILabel()
            return view
        }()
        
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
