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
    @Published var imageModel = ImageModel(
        info: UnsplashInfoModel.createInstance()
    )
    @Published var isLoading = false
    
    private var tmpInfoModel: UnsplashInfoModel?
    
    var cancellables: Set<AnyCancellable> = []
    
    func requestImage() {
        isLoading = true
        networkManager.getImageInfo()
            .sink { complition in
                print(complition)
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.tmpInfoModel = value
                
                self.requestImageUrl(url: value.urls.regular)
            }
            .store(in: &cancellables)
    }
    
    func requestImageUrl(url: String) {
        networkManager.getImage(url: url)
            .sink { complition in
                print(complition)
            } receiveValue: { [weak self] value in
                self?.imageModel.rawImage = value.data
                self?.imageModel.info = (self?.tmpInfoModel)!
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
