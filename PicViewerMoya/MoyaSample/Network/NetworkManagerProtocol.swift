//
//  NetworkManager.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation

import Foundation
import Combine

public typealias GetImageInfoPublisher = AnyPublisher<UnsplashInfoModel, Error>
public typealias GetImagePublisher = AnyPublisher<ImageModel, Error>

public protocol NetworkManagerProtocol {
//    func search(query: String, queryType: SearchQueryType, in databases: [Database]) -> SearchResultPublisher
    func getImageInfo() -> GetImageInfoPublisher
    func getImage(url: String) -> GetImagePublisher
}
