//
//  MoyaNetworkManager.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation
import Moya
import Combine

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
//    public func search(query: String, queryType: SearchQueryType, in databases: [Database]) -> SearchResultPublisher {
//        let payload = SearchRequest(
//            token: apiToken,
//            query: query,
//            type: queryType,
//            databases: databases.map { $0.identifier }.joined(separator: ",")
//        )
//
//        return provider
//            .requestPublisher(.search(payload))
//            .decode(as: SearchResponse.self)
//            .map(\.results)
//            .eraseToAnyPublisher()
//    }
    
//    public func getMeaning(of word: Word) -> GetMeaningResultPublisher {
//        let payload = GetMeaningRequest(
//            token: apiToken,
//            title: word.nonEmptyTitle,
//            database: word.db,
//            number: word.number
//        )
//
//        let decoder = JSONDecoder()
//        decoder.userInfo[.isForGetWordMeaning] = true
//
//        return provider
//            .requestPublisher(.getMeaning(payload))
//            .decode(as: GetMeaningResponse.self, using: decoder)
//            .map(\.word)
//            .eraseToAnyPublisher()
//    }
    
    public func getImageInfo() -> GetImageInfoPublisher {
        let decoder = JSONDecoder()

        return provider.requestPublisher(.randomImageInfo(apiToken))
            .decode(as: UnsplashInfoModel.self, using: decoder)
            .eraseToAnyPublisher()
    }
    
    public func getImage(url: String) -> GetImagePublisher {
        let decoder = JSONDecoder()
        let payload = GetImageByURL(
            apiToken: apiToken,
            url: url)
        
        return provider.requestPublisher(.randomImage(payload))
            .decode(as: ImageModel.self, using: decoder)
            .eraseToAnyPublisher()
    }
    
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
