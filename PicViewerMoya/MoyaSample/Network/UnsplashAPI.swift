//
//  UnsplashAPI.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum Unsplash {
    case randomImageInfo(String)
    case randomImage(GetImageByURL)
}

extension Unsplash: TargetType {
    public var baseURL: URL {
        switch self {
        case .randomImageInfo(_):
            return URL(string: "https://api.unsplash.com")!
        case .randomImage(let payload):
            return URL(string: payload.url)!
        }
    }
    public var path: String {
        switch self {
        case .randomImageInfo(_):
            return "/photos/random"
        default:
            return String()
        }
    }
    public var method: Moya.Method { .get }

    public var task: Task { .requestPlain  }

    public var validationType: ValidationType { .none  }

    public var sampleData: Data { Data() }

    public var headers: [String: String]? {
        switch self {
        case .randomImageInfo(let apiToken):
            return ["Authorization": "Client-ID \(apiToken)"]
        default:
            return [:]
        }
    }

}

public func url(_ route: TargetType) -> String {
    route.baseURL.appendingPathComponent(route.path).absoluteString
}

//MARK: - API request
public struct GetImageByURL {
    let apiToken: String
    let url: String
}

