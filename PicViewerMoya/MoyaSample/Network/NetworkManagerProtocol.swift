//
//  NetworkManager.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation

import Foundation
import Combine
import Moya

public typealias GetImageInfoPublisher = AnyPublisher<UnsplashInfoModel, Error>
public typealias GetImagePublisher = AnyPublisher<Response, MoyaError>

public protocol NetworkManagerProtocol {
    func getImageInfo() -> GetImageInfoPublisher
    func getImage(url: String) -> GetImagePublisher
}
