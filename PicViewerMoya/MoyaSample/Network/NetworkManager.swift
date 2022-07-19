//
//  MoyaNetworkManager.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation
import Moya
import Combine

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public final class NetworkManager {
    typealias Provider = MoyaProvider<Unsplash>
    
    
    public static var `default`: NetworkManager {
        let provider = Provider(
            plugins: [
                NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))
            ]
        )
        return NetworkManager(
            provider: provider,
            apiToken: "M9YU6SWPK45Eh0MKhz1e8dbT68ly62P5n2PTVl3MZfA"
        )
    }
    
    private let provider: Provider
    private let apiToken: String
    
    init(provider: Provider, apiToken: String) {
        self.provider = provider
        self.apiToken = apiToken
    }
}

extension NetworkManager: NetworkManagerProtocol {
    public func getImageInfo() -> GetImageInfoPublisher {
        let decoder = JSONDecoder()

        return provider.requestPublisher(.randomImageInfo(apiToken))
            .decode(as: UnsplashInfoModel.self, using: decoder)
            .eraseToAnyPublisher()
    }
    
    public func getImage(url: String) -> GetImagePublisher {
        let payload = GetImageByURL(
            apiToken: apiToken,
            url: url)
        
        return provider.requestPublisher(.randomImage(payload))
            .eraseToAnyPublisher()
    }
    
}


