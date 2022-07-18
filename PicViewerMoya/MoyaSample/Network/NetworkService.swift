//
//  NetworkService.swift
//  MoyaSample
//
//  Created by Илья Аникин on 15.07.2022.
//

import Foundation

//struct Service {
//    static let mockData = 1...10
//    
//    static func fetch(complition: @escaping (Result<String, Error>) -> Void) {
//        mockData.forEach { value in
//            let delay = DispatchTimeInterval.seconds(value)
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                if value == 7 {
//                    complition(.failure(ServiceError.invalid))
//                    return
//                }
//                complition(.success("\(value)"))
//            }
//        }
//    }
//    
//    static func fetchModel(complition: @escaping (Result<TimeModel, Error>) -> Void) {
//        mockData.forEach { value in
//            let delay = DispatchTimeInterval.seconds(value)
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                complition(.success(TimeModel(seconds: value)))
//            }
//        }
//    }
//}
//
//struct ServiceError {
//    static let invalid = NSError(domain: "7 is invalid", code: 1, userInfo: nil)
//}
