//
//  Extensions+Combine.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation
import Combine
import Moya

extension Publisher where Output == Moya.Response {
    
    func decode<Model: Decodable>(as Model: Model.Type, using decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Model, Error>  {
        return self
            .map(\.data)
            .tryMap { try decoder.decode(Model.self, from: $0) }
            .eraseToAnyPublisher()
    }
    
}
