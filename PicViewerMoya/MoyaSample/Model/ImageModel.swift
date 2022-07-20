//
//  ImageModel.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import Foundation
import SwiftUI

public struct ImageModel {
    var info: UnsplashInfoModel
    var rawImage: Data?
}

extension Image {
    init(data: Data?) {
        if let data = data, let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        }
        else {
            self.init("nocontent")
        }
    }
}

extension Image {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
}


