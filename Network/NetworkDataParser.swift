//
//  NetworkDataParser.swift
//  PicViewer
//
//  Created by Ильяяя on 20.05.2022.
//

import Foundation

class NetworkDataParser{
    let networkService = NetworkService()
    
    func fetchImage(complition: @escaping ((UnsplashPhoto?, (String, Bool)?)) -> Void){
        networkService.request() { (data, error) in
            if let _ = error {
                let errorString = NetworkError.ConnectionError.rawValue
                complition((nil, (errorString,true)))
                return
            }
            let unsplashPhotoResult = self.decodeJSON(type: UnsplashPhoto.self, from: data)
            complition(unsplashPhotoResult)
            
        }
    }
    
    func fetchImages(complition: @escaping (UnsplashPhoto?) -> Void){
        networkService.request() { (data, error) in
            if let _ = error {
                complition(nil)
                return
            }
            let decode = self.decodeJSON(type: UnsplashPhoto.self, from: data)
            complition(decode.0)
        }
    }
    
    func decodeJSON<T:Decodable>(type:T.Type, from data: Data?) -> (T?,(String, Bool)?){
        guard let data = data else {return (nil,nil)}
        let decoder = JSONDecoder()
        do {
            let objects = try decoder.decode(type.self, from: data)
            return (objects,nil)
        } catch let jsonError {
            let errorString = NetworkError.ServiceError.rawValue
            return (nil, (errorString, false))
        }
    }
}
