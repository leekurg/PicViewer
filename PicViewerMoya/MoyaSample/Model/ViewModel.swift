//
//  ViewModel.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import Foundation
import Combine
import Moya

class ViewModel: ObservableObject {
    @Published var infoModel = UnsplashInfoModel(id: "id", width: 0, height: 0, created_at: "---", urls: UnsplashInfoModel.ImageUrls(regular: "--"), user: nil)
    @Published var imageModel = ImageModel(data: Data())
    
    var cancellables: Set<AnyCancellable> = []
    
    func requestImage() {
        networkManager.getImageInfo()
            .sink { complition in
                print(complition)
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.infoModel = value
                
                self.requestImageUrl(url: self.infoModel.urls.regular)
            }
            .store(in: &cancellables)
    }
    
    func requestImageUrl(url: String) {
        networkManager.getImage(url: url)
            .sink { complition in
                print(complition)
            } receiveValue: { [weak self] value in
                self?.imageModel.data = value.data
            }
            .store(in: &cancellables)
    }
}
